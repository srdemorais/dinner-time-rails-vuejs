class Recipe < ApplicationRecord

  validates :title, presence: true
  validates :ingredients, presence: true

  # Custom class method for filtering recipes
  # This method finds recipes that contain ALL of the given keywords in their ingredients
  def self.find_by_all_ingredients(keywords)
    return Recipe.none if keywords.blank?

    conditions = []
    search_terms_for_query = []

    keywords.each do |keyword|
      conditions << "EXISTS (SELECT 1 FROM unnest(recipes.ingredients) AS ri WHERE ri ILIKE ?)"
      search_terms_for_query << "%#{keyword.strip.downcase}%" # Ensure consistent stripping/downcasing
    end

    Recipe.where(conditions.join(' AND '), *search_terms_for_query)
  end
end