Feature: Send outgoing message
  Should be able to send outgoing message

  Scenario: Send message with no webhook
    Given a mobile number
    And no embedded short hash
    And no reply webhook
    When I send a message request to the SMS API
    Then the SMS API should respond with a 200 response code

  Scenario: Send message with webhook and reply details
    Given a mobile number
    And an embedded short hash and reply number
    And a reply webhook
    When I send a message request to the SMS API
    Then the SMS API should respond with a 200 response code