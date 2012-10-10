Feature: Yacht Search
  Scenario: User input keyword of yacht searching
    Given I am on the home page
    And I fill in "destination" with ""
    And I select '2 person' from 'people'
    When I press "Search"
    And I should see "1 Person"

  @javascript
  Scenario: Use filter yacht searching result
    Given I am on the home page
    When I check "mono"
    And I select '1' from 'cabin'
    And I check 'Kastela'
    And I selct '19' from length
    Then I should see "25" within ".value"
    When I press "√"
    Then I should see "5" within ".value"