module Api
  module V1
    class RecipesController < ApplicationController
      def index
        ingredients_query = params[:ingredients]

        # --- Pagination Parameters ---
        # Get page number from params, default to 1
        page = params.fetch(:page, 1).to_i
        # Get items per page from params, default to a reasonable number (e.g., 10 or 25)
        per_page = params.fetch(:per_page, 10).to_i
        # Ensure per_page is within a reasonable range to prevent abuse (e.g., 1 to 100)
        per_page = [per_page, 100].min # Max 100 per page
        per_page = [per_page, 1].max   # Min 1 per page
        # --- End Pagination Parameters ---
        
        search_results = Recipe.none

        if ingredients_query.present?
          # Split the query string by comma, strip whitespace, and remove blanks
          # Convert to lowercase for case-insensitive comparison
          search_ingredients = ingredients_query.split(',').map { |s| s.strip.downcase }.reject(&:blank?)

          if search_ingredients.any?
            # Call the custom class method from the model
            search_results = Recipe.find_by_all_ingredients(search_ingredients)
          end
        end

        # Apply kaminari pagination to the search results (which might be all recipes or filtered ones)
        paginated_recipes = search_results.page(page).per(per_page)

        # --- Prepare JSON Response with Pagination Metadata ---
        recipes_json = paginated_recipes.as_json(only: [
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

        render json: {
          recipes: recipes_json,
          pagination: {
            current_page: paginated_recipes.current_page,
            next_page: paginated_recipes.next_page,
            prev_page: paginated_recipes.prev_page,
            total_pages: paginated_recipes.total_pages,
            total_count: paginated_recipes.total_count,
            per_page: paginated_recipes.limit_value # 'limit_value' is Kaminari's way to get items per page
          }
        }
      end
    end
  end
end