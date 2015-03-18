require './api/services/hash_service'
require './api/services/config_service'
require './api/repositories/message_repository'
require './api/utils/rest_util'
require './api/models/message'
require './api/models/webhook'
require './api/errors/sms_error'
require './api/constants/error_constants'

class MessageService

  include ErrorConstants::MessageErrors

  def initialize(message_repository = MessageRepository, hash_service = HashService,
                 config_service = ConfigurationService, rest_util = RestUtil)
    @message_repository = message_repository.new
    @hash_service = hash_service.new
    @config_service = config_service.new
    @rest_util = rest_util.new
  end

  def find(message_id)

  end

  def get_all
    @message_repository.get_all
  end

  def get_messages_with_pending_webhooks
    @message_repository.get_messages_with_pending_webhooks
  end

  def create(data)
    short_hash = @hash_service.generate_short_hash
    reply_number = @config_service.get_config[:sms_gateway_reply_number]

    number = data[:number]
    message = data[:message] % {SHORT_HASH: short_hash, REPLY_NUMBER: reply_number}
    webhook = data[:webhook]

    # Step 1: send the message to the external service
    message_id = send_to_sms_gateway(message, number)

    # Step 2: save the message locally
    @message_repository.save_message(number, message, message_id, short_hash, webhook)

  end

  def update_inbound_message(short_hash, sender_number, message_id)
    matched_message = @message_repository.get_message_by_short_hash short_hash

    raise SmsError, MESSAGE_NOT_FOUND_ERROR if matched_message == nil
    raise SmsError, MESSAGE_ALREADY_HANDLED_ERROR if matched_message.incoming_message_id.to_s != ''

    # Step 1: update the record with the incoming sms
    matched_message.incoming_message = short_hash
    matched_message.incoming_message_id = message_id
    @message_repository.update_message matched_message

    # NOTE: below will be handled in the InboundMessageProcessorService
    # # Step 2: execute the callback defined in the webhook
    # uri = matched_message.webhook.uri
    # auth_header = matched_message.webhook.auth_header
    # payload = matched_message.webhook.body
    # @rest_util.execute_post uri, auth_header, payload

  end

  def update_message_webhook_status(message, status)
    message.webhook.status = status
    @message_repository.update_message message
  end

  private
  def send_to_sms_gateway(message, number)
    config = @config_service.get_config

    payload = {:api_key => config[:sms_gateway_api_key], :api_secret => config[:sms_gateway_api_secret],
               :from => 'ig-sms-api', :to => number, :text => message}.to_json

    # See https://docs.nexmo.com/index.php/sms-api/send-message for sample response
    result = @rest_util.execute_post config[:sms_gateway_api_uri], '', payload
    raise SmsError, MESSAGE_DELIVERY_ERROR if result.response_code != 200

    message_result = JSON.parse(result.response_body)
    response_message = message_result['messages'][0]

    raise SmsError, response_message['error-text'] if response_message['status'].to_i != 0

    response_message['message-id']
  end

end