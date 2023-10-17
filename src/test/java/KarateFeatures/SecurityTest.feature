Feature: Security token generation
  Scenario: send request to the /api/token
    Given url "https://qa.insurance-api.tekschool-students.com"
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200

  Scenario Outline: test with wrong Data
    Given url "https://qa.insurance-api.tekschool-students.com"
    And path "/api/token"
    And request
    """
    {"username": "<username>", "password": "<password>"}
    """
    When method post
    And print response
    Then status <expectedStatus>
    And assert response.httpStatus == "<httpStatus>"
    And assert response.errorMessage == "<errorMessage>"

    Examples:
      |username|password|expectedStatus|httpStatus|errorMessage|
      |WrongUsername|tek_supervisor|404|NOT_FOUND |User WrongUsername not found|
      |supervisor   |wrongPassword |400|BAD_REQUEST|Password not matched       |

