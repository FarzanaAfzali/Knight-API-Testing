Feature: Generate Feature Token
  Scenario: Get new Token
    Given url "https://qa.insurance-api.tekschool-students.com"
    Given path "/api/token"
    Given request {"username":  "supervisor", "password": "tek_supervisor"}
    When method post
    And status 200
    And print response