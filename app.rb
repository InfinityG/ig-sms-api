require 'sinatra/base'
require 'openssl'
require 'webrick'
require 'webrick/https'
require 'logger'
require 'mongo'
require 'mongo_mapper'

require './api/routes/cors'
require './api/routes/auth'
require './api/routes/messages'
require './api/services/config_service'
require './api/services/inbound_message_processor_service'

class ApiApp < Sinatra::Base

  configure do

    config = ConfigurationService.new.get_config

    # Register routes
    register Sinatra::CorsRoutes
    register Sinatra::AuthRoutes
    register Sinatra::MessageRoutes

    if config[:mongo_replicated] == 'true'
      MongoMapper.connection = Mongo::MongoReplicaSetClient.new([config[:mongo_host_1], config[:mongo_host_2], config[:mongo_host_3]])
    else
      conn_pair = config[:mongo_host_1].split(':')
      MongoMapper.connection = Mongo::MongoClient.new(conn_pair[0], conn_pair[1])
    end

    MongoMapper.database = config[:mongo_db]

    # Start the queue service for inbound messages from the SMS provider...
    message_processor_service = InboundMessageProcessorService.new
    message_processor_service.start

  end

end