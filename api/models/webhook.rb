module SmartSms
  module Models
    class Webhook
      include MongoMapper::EmbeddedDocument

      key :uri, String
      key :auth_header, String
      key :body, String
    end
  end
end