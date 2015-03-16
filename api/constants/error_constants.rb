module ErrorConstants

  module MessageErrors
    MESSAGE_DELIVERY_ERROR = 'An error was experienced while delivering your message'
  end

  module ValidationErrors
    INVALID_FIRST_NAME = 'Invalid first name'
    INVALID_LAST_NAME = 'Invalid last name'
    INVALID_USERNAME = 'Invalid username'
    INVALID_PASSWORD = 'Invalid password. Minimum 8 characters length, with at least 1 upper case, 1 numeric and 1 special character'
    INVALID_PUBLIC_KEY = 'Invalid public key'
    INVALID_DOMAIN = 'Invalid domain'
    NO_CHALLENGE_FOUND = 'No challenge found!'
    INVALID_CHALLENGE_DATA = 'Invalid challenge data'
    INVALID_CHALLENGE_SIGNATURE = 'Invalid challenge signature'
  end
end