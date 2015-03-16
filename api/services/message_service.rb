require './api/services/hash_service'
require './api/services/config_service'
require './api/repositories/message_repository'
require './api/utils/rest_util'
require './api/models/message'
require './api/models/webhook'

class MessageService
  def initialize(message_repository = MessageRepository, hash_service = HashService,
                 config_service = ConfigurationService, rest_util = RestUtil)
    @message_repository = message_repository.new
    @hash_service = hash_service.new
    @config_service = config_service.new
    @rest_util = rest_util.new
  end

  def find(message_id)

  end

  def find_all
    @message_repository.find_all
  end

  def create(data)
    short_hash = @hash_service.generate_short_hash
    reply_number = @config_service.get_config[:sms_gateway_reply_number]

    number = data[:number]

    # embed the short_hash in the message if the 'SHORT_HASH' placeholder is present
    # embed the reply_number in the message if the 'REPLY_NUMBER' placeholder is present
    message = data[:message] % {SHORT_HASH: short_hash, REPLY_NUMBER: reply_number}

    # if there is a webhook then we expect a response
    webhook = data[:webhook]

    config = @config_service.get_config

    # Step 1: send the message to the external service
    payload = {:api_key => config[:sms_gateway_api_key], :api_secret => config[:sms_gateway_api_secret],
               :from => 'ig-sms-api', :to => number, :text => message}.to_json
    result = @rest_util.execute_post config[:sms_gateway_api_uri], '', payload

    if result.response_code == 200
      # See https://docs.nexmo.com/index.php/sms-api/send-message for sample response

      message_result = JSON.parse(result.response_body)
      response_message = message_result['messages'][0]

      # Step 2: save the message locally
      if response_message['status'].to_i == 0
        message_id = response_message['message-id']
        @message_repository.save_message(number, message, message_id, short_hash, webhook)
      else
        raise SmsError, response_message['error-text']
      end

    end

  end

  def update(short_hash, message_id)
    if short_hash.to_s != ''
      matched_message = @message_repository.get_message_by_short_hash short_hash

      # Step 1: update the record with the incoming sms
      if matched_message != nil && matched_message.incoming_message_id.to_s != ''
        matched_message.incoming_message = short_hash
        matched_message.incoming_message_id = message_id
        @message_repository.update_message matched_message
      end

      # Step 2: execute the callback defined in the webhook
      uri = matched_message.webhook.uri
      auth_header = matched_message.webhook.auth_header
      payload = matched_message.webhook.body.to_json
      @rest_util.execute_post uri, auth_header, payload
    end
  end

end