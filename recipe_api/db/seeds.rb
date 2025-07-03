# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'json' # Required for JSON parsing

# Path to your JSON data file
json_file_path = Rails.root.join('db', 'recipes.json')

# Check if the JSON file exists
if File.exist?(json_file_path)
  puts "Seeding recipes from #{json_file_path}..."
  Recipe.destroy_all # Good for development to clear data before re-seeding

  # Read the JSON file and parse its content
  json_data = File.read(json_file_path)
  recipes_data = JSON.parse(json_data)

  # Iterate over each recipe hash and create a Recipe record
  recipes_data.each do |recipe_attributes|
    Recipe.create!(recipe_attributes)
  end

  puts "Seeding complete. Created #{Recipe.count} recipes."
else
  puts "Warning: db/recipes.json not found. No recipes seeded from JSON."
  puts "Please create 'db/recipes.json' with your recipe data, or add recipes manually."
end