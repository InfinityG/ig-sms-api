module SmartSms
  module Models
    class Message
      include MongoMapper::Document

      # 2-way message combinations need a compound key to match replies to sent messages:
      # mobile_number + outgoing_message_short_hash

      key :mobile_number, String
      key :outgoing_message, String
      key :outgoing_message_id, String
      key :outgoing_message_state, String  # this can be 'pending' or 'sent'
      key :outgoing_message_short_hash, String  # used to match an incoming message to an outgoing message

      key :incoming_message, String
      key :incoming_message_id, String

      # webhook for associated incoming message (applicable to 2-way only)
      one :webhook, :class_name => 'SmartSms::Models::Webhook'
    end
  end
end