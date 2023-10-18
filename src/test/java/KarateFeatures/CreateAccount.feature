Feature: Create Account Testing
  Background: Base_URL
    Given url "https://qa.insurance-api.tekschool-students.com"

  Scenario: Testing api/accounts/add-primary-account
    * def tokenObj = callonce read('GenerateToken.feature')
    And print tokenObj
    * def validToken = "Bearer " + tokenObj.response.token

    Given path "/api/accounts/add-primary-account"
    And request
      """ {
  "email": "Hashimi@gmail.com",
  "firstName": "Farzana",
  "lastName": "Hashimi",
  "title": "Mrs",
  "gender": "FEMALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "QA Engineer",
  "dateOfBirth": "1999-04-22",
  } """
    When method post
    Then status 201
    Then print response
    And assert response.email == "Hashimi@gmail.com"

    * def primaryID = response.id

    Given path "/api/accounts/delete-account"
    And param primaryPersonId = primaryID
    And header Authorization = validToken
    When method delete
    Then status 200
    And print response
    And match response contains {"status": true, "message": "Account Successfully deleted"}
