require 'sinatra/base'
require './api/services/message_service'
require './api/validators/message_validator'
require './api/utils/rest_util'
require './api/errors/sms_error'
require 'json'

module Sinatra
  module MessageRoutes
    def self.registered(app)

      app.post '/messages/outbound' do
        data = JSON.parse(request.body.read, :symbolize_names => true)

        begin
          MessageValidator.new.validate_outbound_message data
        rescue ValidationError => e
          status 400  # bad request
          e.message.to_json
        end

        begin
          MessageService.new.create data
          status 200
        rescue SmsError => e
          status 500
          e.message.to_json
        end

      end

      app.get '/messages' do
        begin
          result = MessageService.new.get_all
          status 200
          result.to_json
        rescue
          status 500
        end
      end

      app.get '/messages/inbound' do
        content_type :json

        begin
          # eg:/messages/inbound?msisdn=19150000001&to=12108054321
          # &messageId=000000FFFB0356D1&text=This+is+an+inbound+message
          # &type=text&message-timestamp=2012-08-19+20%3A38%3A23
          sender_id = params['msisdn'].to_i
          message_id = params['messageId']
          text = params['text']
          timestamp = params['message-timestamp']

          MessageService.new.update text, message_id

          status 200
        rescue SmsError => e
          status 200  # this should be 500 but the SMS provider needs a 200
          e.message.to_json
        end

      end
    end

  end
  register MessageRoutes
end