Feature: merging articles

    as avid blogger
    so that I can organize articles
    i want a merge feature

Background: articles have been added to the blog

    Given the following articles exist:
    | This is my first post  | John Doe      | hello world |
    | This is my second post | Steve Johnson | Hi World    |

    And I am on the home page

Scenario: a non-admin tries to merge articles
    Given I am not an admin
    And there are at least two articles
    And I try to merge "This is my first post" and "This is my second post"
    Then it should fail

