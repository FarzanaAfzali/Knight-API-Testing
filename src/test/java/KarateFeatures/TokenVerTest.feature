Feature: Verification of token
  Background: Primary Setup
    Given url "https://qa.insurance-api.tekschool-students.com"
  Scenario: Send valid username and password to get token
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response

    And path "/api/token/verify"
    And param username = "supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    And assert response.message == "Token is valid"

  Scenario: Test token With Wrong username
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And path "/api/token/verify"
    And param username = "WrongUserNAme"
    And param token = response.token
    When method get
    And print response
    And status 400
    And assert response.httpStatus == "BAD_REQUEST"
    And assert response.errorMessage == "Wrong Username send along with Token"