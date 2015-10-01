require 'mongo_mapper'
require 'bson'
require './api/models/message'
require './api/models/webhook'

class SignatureRepository
  def save_signature(number, message, short_hash, webhook_data)

    webhook = nil

    if webhook_data != nil
      webhook = SmartSms::Models::Webhook.new(:uri => webhook_data[:uri],
                                              :auth_header => webhook_data[:auth_header],
                                              :body => webhook_data[:body])
    end

    expect_inbound = (webhook == nil) ? false : true
    webhook_status = expect_inbound ? 'pending' : nil
    inbound_message_status = expect_inbound ? 'pending' : nil

    SmartSms::Models::Message.create(:mobile_number => number,
                                     :short_hash => short_hash,
                                     :expect_inbound => expect_inbound,
                                     :outbound_message => message,
                                     :outbound_message_status => 'pending',
                                     :inbound_message_status => inbound_message_status,
                                     :webhook => webhook,
                                     :webhook_status => webhook_status)

  end

  def update_signature(message)
    message.save
  end

  def get_matched_message_by_number_and_short_hash(number, short_hash, status)
    SmartSms::Models::Message.first(:mobile_number => number,
                                    :short_hash => short_hash,
                                    :outbound_message_status => status)
  end

  def get_incomplete_messages_by_number(number)
    SmartSms::Models::Message.where(:mobile_number => number,
                                    :expect_inbound => true,
                                    :inbound_message_status => 'pending').all
  end

  def get_all
    SmartSms::Models::Message.all
  end

  def get_messages_with_pending_webhooks
    # https://gist.github.com/kinopyo/1547098
    SmartSms::Models::Message.where(:inbound_message_status => 'received',
                                    :webhook_status => 'pending').all
  end

end