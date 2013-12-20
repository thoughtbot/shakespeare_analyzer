Feature: Macbeth Analyzer

  Scenario: Lines per character
    When I run `ruby macbeth_analyzer.rb`
    Then the output should contain "718  Macbeth"
    Then the output should contain "180  Macduff"
