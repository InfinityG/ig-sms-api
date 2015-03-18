require 'mongo_mapper'
require 'bson'
require './api/models/message'
require './api/models/webhook'

class MessageRepository
  def save_message(number, message, message_id, short_hash, webhook_data)

    webhook = nil

    if webhook_data != nil
      webhook = SmartSms::Models::Webhook.new(:uri => webhook_data[:uri],
                                              :auth_header => webhook_data[:auth_header],
                                              :body => webhook_data[:body],
                                              :status => 'pending')
    end

    SmartSms::Models::Message.create(:mobile_number => number,
                   :outgoing_message => message,
                   :outgoing_message_id => message_id,
                   :outgoing_message_short_hash => short_hash,
                   :webhook => webhook)

  end

  def update_message(message)
    message.save
  end

  def get_message_by_short_hash(short_hash)
    SmartSms::Models::Message.first(:outgoing_message_short_hash => short_hash)
  end

  def get_all
    SmartSms::Models::Message.all
    end

  def get_messages_with_pending_webhooks
    SmartSms::Models::Message.where(:webhook.status => 'pending')
  end

end