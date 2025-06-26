require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  
  test "find_by_all_ingredients returns recipes matching all keywords" do
    # Access fixture data using `recipes(:fixture_name)`
    # This assumes test/fixtures/recipes.yml defines these entries.
    recipe1 = recipes(:sugar_cookies)
    recipe4 = recipes(:vanilla_cake)
    recipe_empty = recipes(:empty_recipe) # A placeholder for a recipe that shouldn't match anything

    # Test with keywords that both recipes 1 and 4 should match
    result_recipes = Recipe.find_by_all_ingredients(["sugar", "flour"])
    assert_includes result_recipes, recipe1
    assert_includes result_recipes, recipe4
    assert_equal 2, result_recipes.count # Only 2 recipes should have both sugar and flour

    # Test with keywords that only recipe 4 should match (more specific)
    result_recipes = Recipe.find_by_all_ingredients(["flour", "sugar", "egg"])
    assert_includes result_recipes, recipe4
    assert_equal 2, result_recipes.count

    # Test with keywords that no recipe should match
    result_recipes = Recipe.find_by_all_ingredients(["banana", "chocolate"])
    assert_empty result_recipes
  end

  test "find_by_any_ingredient returns recipes matching any keyword" do
    # Access fixture data
    recipe1 = recipes(:sugar_cookies)
    recipe2 = recipes(:flour_tortillas)
    recipe3 = recipes(:egg_scramble)
    recipe4 = recipes(:vanilla_cake)

    # Test with keywords where multiple recipes should match
    result_recipes = Recipe.find_by_any_ingredient(["sugar", "milk"])
    assert_includes result_recipes, recipe1 # sugar
    assert_includes result_recipes, recipe3 # milk
    assert_includes result_recipes, recipe4 # sugar, milk
    assert_equal 3, result_recipes.count

    # Test with a single keyword
    result_recipes = Recipe.find_by_any_ingredient(["flour"])
    assert_includes result_recipes, recipe1
    assert_includes result_recipes, recipe2
    assert_includes result_recipes, recipe4
    assert_equal 3, result_recipes.count

    # Test with keyword that does not exist
    result_recipes = Recipe.find_by_any_ingredient(["kale"])
    assert_empty result_recipes
  end

  test "find_by_all_ingredients handles empty keywords" do
    result_recipes = Recipe.find_by_all_ingredients([])
    assert_empty result_recipes # Should return an empty relation/array
  end

  test "find_by_any_ingredient handles empty keywords" do
    result_recipes = Recipe.find_by_any_ingredient([])
    assert_empty result_recipes # Should return an empty relation/array
  end
end