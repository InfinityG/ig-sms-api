module SmartSms
  module Models
    class Signature
      include MongoMapper::Document

      key :incoming_message_number, String
      key :incoming_message_id, String
      key :incoming_message_keyword, String
      key :incoming_message_text, String
      key :secret_key, String
      key :contract_id, String
      key :condition_id, String
      key :condition_data, String
      key :status, String
    end
  end
end