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

      # SAMPLE INBOUND MESSAGE FROM NEXMO:
      # eg:/messages/inbound?msisdn=27827255159
      # &to=27877460911
      # &messageId=0200000057C3CD30
      # &text=yK2ba
      # &type=text
      # &keyword=YK2BA
      # &message-timestamp=2015-03-18+10%3A59%3A45

      app.get '/messages/inbound' do

        puts

        begin
          sender_number = params[:msisdn]
          message_id = params[:messageId]
          short_hash = params[:keyword]
          text = params[:text]
          # timestamp = params['message-timestamp']

          result = MessageService.new.update_inbound_message short_hash, text, sender_number, message_id
          puts result

          status 200
        rescue SmsError => e
          status 200  # this should be 500 but the SMS provider needs a 200
          puts e.message.to_json
        end

      end
    end

  end
  register MessageRoutes
end