require 'openssl'

module ConfigurationConstants
  module Environments
    DEVELOPMENT = {
        :host => '0.0.0.0',
        :port => 9004,
        :api_auth_token => ENV['API_AUTH_TOKEN'],
        :mongo_replicated => false,
        :mongo_host_1 => 'localhost:27017',
        :mongo_host_2 => nil,
        :mongo_host_3 => nil,
        :mongo_db => 'sms-db',
        :logger_file => 'app_log.log',
        :logger_age => 10,
        :logger_size => 1024000,
        :default_request_timeout => 60,
        :allowed_origin => '*',
        :sms_gateway_api_uri => 'https://rest.nexmo.com/sms/json',
        :sms_gateway_api_key => ENV['SMS_GATEWAY_API_KEY'],
        :sms_gateway_api_secret => ENV['SMS_GATEWAY_API_SECRET'],
        :sms_gateway_reply_number => ENV['SMS_GATEWAY_REPLY_NUMBER']
    }

    TEST = {
        :host => '0.0.0.0',
        :port => 9004,
        :api_auth_token => ENV['API_AUTH_TOKEN'],
        :mongo_replicated => ENV['MONGO_REPLICATED'],
        :mongo_host_1 => ENV['MONGO_HOST_1'],
        :mongo_host_2 => ENV['MONGO_HOST_2'],
        :mongo_host_3 => ENV['MONGO_HOST_3'],
        :mongo_db => ENV['MONGO_DB'],
        :logger_file => 'app_log.log',
        :logger_age => 10,
        :logger_size => 1024000,
        :default_request_timeout => 60,
        :allowed_origin => '*',
        :sms_gateway_api_uri => 'https://rest.nexmo.com/sms/json',
        :sms_gateway_api_key => ENV['SMS_GATEWAY_API_KEY'],
        :sms_gateway_api_secret => ENV['SMS_GATEWAY_API_SECRET'],
        :sms_gateway_reply_number => ENV['SMS_GATEWAY_REPLY_NUMBER']
    }

    PRODUCTION = {
        :host => '0.0.0.0',
        :port => 9004,
        :api_auth_token => ENV['API_AUTH_TOKEN'],
        :mongo_replicated => ENV['MONGO_REPLICATED'],
        :mongo_host_1 => ENV['MONGO_HOST_1'],
        :mongo_host_2 => ENV['MONGO_HOST_2'],
        :mongo_host_3 => ENV['MONGO_HOST_3'],
        :mongo_db => ENV['MONGO_DB'],
        :logger_file => 'app_log.log',
        :logger_age => 10,
        :logger_size => 1024000,
        :default_request_timeout => 60,
        :allowed_origin => '*',
        :sms_gateway_api_uri => 'https://rest.nexmo.com/sms/json',
        :sms_gateway_api_key => ENV['SMS_GATEWAY_API_KEY'],
        :sms_gateway_api_secret => ENV['SMS_GATEWAY_API_SECRET'],
        :sms_gateway_reply_number => ENV['SMS_GATEWAY_REPLY_NUMBER']
    }

  end
end