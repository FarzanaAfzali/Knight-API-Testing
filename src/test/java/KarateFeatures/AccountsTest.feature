Feature: Account page API testing
  Background:
    Given url "https://qa.insurance-api.tekschool-students.com"

  Scenario: Test "/api/accounts/get-account"
    * def tokenResult = callonce read('GenerateToken.feature')
    And print tokenResult

    * def validToken = "Bearer " + tokenResult.response.token
    Given path "/api/accounts/get-account"
    And header Authorization = validToken
    And param primaryPersonId = 374
    When method get
    And status 200
    And assert response.primaryPerson.firstName == "xyz"
    And print response


  Scenario: Testing endpoint /api/accounts/get-account with primary person not existing
    * def tokenResult = callonce read('GenerateToken.feature')
    And print tokenResult

    * def validToken = "Bearer " + tokenResult.response.token
    * def primaryId = 890
    Given path "api/accounts/get-account"
    Given header Authorization = validToken
    Given param primaryPersonId = primaryId
    When method get
    Then status 404
    And print response
    And assert response.httpStatus == "NOT_FOUND"
    And assert response.errorMessage == "Account with id " + primaryId + " not found"


