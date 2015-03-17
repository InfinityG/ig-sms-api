module ErrorConstants

  module MessageErrors
    MESSAGE_DELIVERY_ERROR = 'An error was experienced while delivering your message'
    MESSAGE_ALREADY_HANDLED_ERROR = 'The reply message was already handled!'
    MESSAGE_NOT_FOUND_ERROR = 'A matching message could not be found!'
  end

  module ValidationErrors
    INVALID_PHONE_NUMBER = 'Invalid phone number'
    INVALID_MESSAGE = 'Invalid message'
    INVALID_WEBHOOK_URI = 'Invalid webhook uri'
    INVALID_WEBHOOK_AUTH_HEADER = 'Invalid webhook auth header'
    INVALID_WEBHOOK_BODY = 'Invalid webhook body'
  end
end