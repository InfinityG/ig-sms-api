require 'sinatra/base'
require './api/services/config_service'

module Sinatra
  module AuthRoutes
    def self.registered(app)

      #this filter applies to everything except options, challenge and login routes
      app.before do
        if (request.request_method == 'OPTIONS') ||
            (request.request_method == 'GET' && request.path_info == '/messages/inbound') # this is for inbound callbacks from SMS provider
          return
        else
          auth_header = env['HTTP_AUTHORIZATION']

            # all other routes are the API - these require the api token
            if auth_header == nil || auth_header != ConfigurationService.new.get_config[:api_auth_token]
              halt 401, 'Unauthorized!'
            end

        end
      end

    end
  end

  register AuthRoutes
end