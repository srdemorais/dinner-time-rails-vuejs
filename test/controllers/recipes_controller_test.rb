require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest

  test "should get search results for 'all' matching ingredients" do
    # Access fixture data
    recipe1 = recipes(:sugar_cookies)
    recipe4 = recipes(:vanilla_cake)

    get search_recipes_url, params: { keywords: "flour,sugar", match_all: "true" }
    assert_response :ok
    json_response = JSON.parse(response.body)

    expected_ids = [recipe1.id, recipe4.id].sort
    actual_ids = json_response.map { |r| r["id"] }.sort
    assert_equal expected_ids, actual_ids
    assert_equal 2, json_response.count
  end

  test "should return empty array if no matching recipes for 'all' keywords" do
    get search_recipes_url, params: { keywords: "banana,chocolate", match_all: "true" }
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_empty json_response
  end

  test "should return empty array if no matching recipes for 'any' keywords" do
    get search_recipes_url, params: { keywords: "kale", match_all: "false" }
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_empty json_response
  end

  test "should return all recipes if no keywords are provided" do
    # You need to count recipes from fixtures if you are relying on them
    # Ensure all fixtures are correctly defined in test/fixtures/recipes.yml
    total_fixture_recipes = 5 # Corrected to 5, as there are 5 entries in recipes.yml
    get search_recipes_url # No params
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_equal total_fixture_recipes, json_response.count
  end
end