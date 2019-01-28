require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'lib/cookbook.rb'
require_relative 'lib/recipe.rb'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'lib/recipes.csv')
cookbook   = Cookbook.new(csv_file)

get '/' do
  @recipes = cookbook.recipes
  # binding.pry
  erb :index
end

# [...]

get '/about' do
  erb :about
end

get '/new' do
  erb :new
end

post '/recipes' do
  # p params[:name]
  # p params[:description]
  cookbook.add_recipe(Recipe.new(params[:name], params[:description]))
  redirect "/"
end

post '/delete' do
  # binding.pry
  cookbook.remove_recipe(params.first[0].to_i)
  redirect "/"
end
