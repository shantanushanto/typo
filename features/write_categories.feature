Feature: Write Categories
  As a blog administrator
  I want to create and edit categories
  So that my blog posts can be organized in different ways

  Background:
    Given the blog is set up
    And I am logged into the admin panel

Scenario: Successfully go to admin categories page
  	Given I am on the admin page
  	When I follow "Categories"
  	Then I should be on the admin categories page

Scenario: Successfully create a category
	Given I am on the admin categories page
	When I fill in "Name" with "People"
	And I press "Save"
	Then I should see "Category was successfully saved."
