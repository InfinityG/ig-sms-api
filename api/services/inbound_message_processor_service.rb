require './api/services/message_service'
require './api/utils/rest_util'

class InboundMessageProcessorService

  # this will start a new thread which will periodically retrieve pending
  # webhooks from the DB and attempt to process them
  def start
    @service_thread = Thread.new {

      message_service = MessageService.new
      rest_util = RestUtil.new

      while true

        begin
          pending_items = message_service.get_messages_with_pending_webhooks

          pending_items.each do |item|
            # process webhooks
            uri = item.webhook.uri
            auth_header = item.webhook.auth_header
            payload = item.webhook.body
            result = rest_util.execute_post uri, auth_header, payload

            # update status to 'complete'
            message_service.update_message_webhook_status item, 'complete' if result.response_code == 200
          end

        rescue Exception => e
          puts "Error processing message item! || Error: #{e}"
        end

        sleep 10.0
      end
    }
  end
end