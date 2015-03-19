module SmartSms
  module Models
    class Message
      include MongoMapper::Document

      # 2-way message combinations need a compound key to match replies to sent messages:
      # mobile_number + outgoing_message_short_hash

      key :mobile_number, String
      key :short_hash, String  # used to match an incoming message to an outgoing message
      key :expect_inbound, Boolean

      key :outbound_message, String
      key :outbound_message_id, String
      key :outbound_message_status, String  # this can be 'pending' or 'sent'

      key :inbound_message, String
      key :inbound_message_id, String
      key :inbound_message_status, String # this can be 'pending' or 'received'

      # webhook for associated incoming message (applicable to 2-way only)
      one :webhook, :class_name => 'SmartSms::Models::Webhook'
      key :webhook_status, String
    end
  end
end