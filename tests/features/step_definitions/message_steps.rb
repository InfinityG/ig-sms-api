require_relative '../../../api/utils/rest_util'
require_relative '../../../tests/config'
require 'json'
require 'minitest'

Given(/^a mobile number$/) do
  @mobile_number = '+27827255159'
end

And(/^no embedded short hash$/) do
  @message = 'Test message'
  end

And(/^an embedded short hash and reply number$/) do
  @message = 'Test message: send %{SHORT_HASH} to %{REPLY_NUMBER}'
end

And(/^no reply webhook$/) do
  @webhook = nil
  end

And(/^a reply webhook$/) do
  @webhook = {:uri => 'http://identity.infinity-g.com/confirmations', :auth_header => 'gouygiuyiu', :body => '{"number":"21424124"}'}
end

When(/^I send a message request to the SMS API/) do
  # payload data: {:number => "0822323434", :message => "Congratulations!...",
  #   :webhook => {"uri"":"http://identity.infinity-g.com/confirmations", "auth_header":"", "body":"sdfsdf"}}

  payload = {:number => @mobile_number, :message => @message, :webhook => @webhook}.to_json
  rest_util = RestUtil.new
  @response = rest_util.execute_post "#{SMS_API_URI}/messages/outbound", SMS_API_AUTH_KEY, payload
end

Then(/^the SMS API should respond with a (\d+) response code$/) do |arg|
  assert @response.response_code.to_s == arg.to_s
end