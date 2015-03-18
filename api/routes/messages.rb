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
        status 200
      end

      app.post '/messages/inbound' do
        data = JSON.parse(request.body.read)

        begin
          # eg:/messages/inbound?msisdn=27827255159
          # &to=27877460911
          # &messageId=0200000057C3CD30
          # &text=yK2ba
          # &type=text
          # &keyword=YK2BA
          # &message-timestamp=2015-03-18+10%3A59%3A45

          sender_number = data['msisdn'].to_i
          message_id = params['messageId']
          short_hash = params['text']
          timestamp = params['message-timestamp']

          MessageService.new.update sender_number, short_hash, message_id

          status 200
        rescue SmsError => e
          status 500  # this should be 500 but the SMS provider needs a 200
          e.message.to_json
        end

      end
    end

  end
  register MessageRoutes
end