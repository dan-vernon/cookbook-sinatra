require 'csv'
require_relative 'recipe'
require 'pry-byebug'


class Cookbook
  attr_reader :recipes

  def initialize(csv_file_path)
    @csv = csv_file_path
    @recipes = []
    load_csv
  end

  def load_csv
    CSV.foreach(@csv) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    # add each recipe instance to @recipes array of instances
    @recipes << recipe
    save_csv
    # iterate over each recipe instance and add it to the CSV
  end

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv, "wb", csv_options) do |csv|
      @recipes.each do |recipe|
        # binding.pry
        csv << [recipe.name.to_s, recipe.description]
      end
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end
end
