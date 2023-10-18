Feature:Plan code Testing
  Background: Before Test
    Given url "https://qa.insurance-api.tekschool-students.com"

  Scenario: Validate /api/plans/get-all-plan-code
    Given path "/api/token"
    Given request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    And status 200
    And print response
    # the * is used for those that aren't part of When Given And.
    * def validToken = "Bearer " + response.token
    Given path "/api/plans/get-all-plan-code"
    And header Authorization = validToken
    When method get
    And status 200
    And print response
    And assert response[0,1,2,3].planExpired == false