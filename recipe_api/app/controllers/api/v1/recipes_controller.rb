module Api
  module V1
    class RecipesController < ApplicationController
      def index
        ingredients_query = params[:ingredients]
        @recipes = [] # Initialize to empty array

        if ingredients_query.present?
          # Split the query string by comma, strip whitespace, and remove blanks
          # Convert to lowercase for case-insensitive comparison
          search_ingredients = ingredients_query.split(',').map { |s| s.strip.downcase }.reject(&:blank?)

          if search_ingredients.any?
            # Call the custom class method from the model
            @recipes = Recipe.find_by_all_ingredients(search_ingredients)
          end
        end

        # Render the recipes as JSON
        # Update `only` array to match your actual migration columns
        render json: @recipes.as_json(only: [
          :id,
          :title,
          :cook_time,
          :prep_time,
          :ingredients,
          :ratings,
          :cuisine,
          :category,
          :author,
          :image,
          :created_at,
          :updated_at
        ])
      end
    end
  end
end