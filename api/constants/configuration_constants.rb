require 'openssl'

module ConfigurationConstants
  module Environments
    DEVELOPMENT = {
        :host => '0.0.0.0',
        :port => 9004,
        :api_auth_token => '7b2ebe64dc9149ac8a9e923bf2a6b233',
        :mongo_host => 'localhost',
        :mongo_port => 27017, # default is 27017
        :mongo_db => 'ig-sms',
        :logger_file => 'app_log.log',
        :logger_age => 10,
        :logger_size => 1024000,
        :default_request_timeout => 60,
        :allowed_origin => 'http://localhost:8000, http://54.154.155.144:9002, http://ec2-54-154-155-144.eu-west-1.compute.amazonaws.com:9002',
        :sms_gateway_api_uri => 'https://rest.nexmo.com/sms/json',
        :sms_gateway_api_key => '03d116ba',
        :sms_gateway_api_secret => 'fb232c80',
        :sms_gateway_reply_number => '27877460911'
    }

    TEST = {
        :host => '0.0.0.0',
        :port => 9004,
        :api_auth_token => '7b2ebe64dc9149ac8a9e923bf2a6b233',
        :mongo_host => 'localhost',
        :mongo_port => 27017, # default is 27017
        :mongo_db => 'ig-sms',
        :logger_file => 'app_log.log',
        :logger_age => 10,
        :logger_size => 1024000,
        :default_request_timeout => 60,
        :allowed_origin => 'http://54.154.155.144:9002',
        :sms_gateway_api_uri => 'https://rest.nexmo.com/sms/json',
        :sms_gateway_api_key => '03d116ba',
        :sms_gateway_api_secret => 'fb232c80',
        :sms_gateway_reply_number => '27877460911'
    }

    #
    # PRODUCTION = {
    #     :host => '10.0.0.208',
    #     :port => 9002,
    #     :ssl_cert_path => '/etc/ssl/certs/server.crt',
    #     :ssl_private_key_path => '/etc/ssl/private/server.key',
    #     :api_auth_token => 'f20298dddd5142be9616b15baee5da9c',
    #     :admin_username => 'admin',
    #     :admin_password => '12billyBob!*/',
    #     :mongo_host => '10.0.1.46',
    #     :mongo_port => 27017,
    #     :mongo_db => 'contracts',
    #     :mongo_db_user => 'contractsUser',
    #     :mongo_db_password => 'g4f1jh4g1234!',
    #     :logger_file => 'app_log.log',
    #     :logger_age => 10,
    #     :logger_size => 1024000,
    #     :default_request_timeout => 60,
    #     :allowed_origin => 'localhost'
    #     # :static => true,
    #     # :public_folder => 'docs'
    # }
  end
end