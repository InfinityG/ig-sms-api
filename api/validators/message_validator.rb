require 'json'
require_relative '../../api/errors/validation_error'
require_relative '../../api/constants/error_constants'
require_relative '../../api/utils/validation_util'

class MessageValidator
  include ErrorConstants::ValidationErrors

  def validate_outbound_message(data)
    errors = []

    errors.push INVALID_PHONE_NUMBER unless ValidationUtil.validate_string data[:number]
    errors.push INVALID_MESSAGE unless ValidationUtil.validate_string data[:message]

    if data[:webhook] != nil
      errors.push INVALID_WEBHOOK_URI unless ValidationUtil.validate_string data[:webhook][:uri]
      errors.push INVALID_WEBHOOK_AUTH_HEADER unless ValidationUtil.validate_string data[:webhook][:auth_header]
      errors.push INVALID_WEBHOOK_BODY unless ValidationUtil.validate_string data[:webhook][:body]
    end

    raise ValidationError, {:valid => false, :errors => errors}.to_json if errors.count > 0
  end

end