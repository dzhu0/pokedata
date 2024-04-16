class ShapesController < ApplicationController
    # Method to retrieve a list of shapes with the count of associated pokemons
    def index
        @shapes = Shape.left_joins(:pokemons) # Left join to include shapes without pokemons
                       .select('shapes.*, COUNT(pokemons.id) AS pokemon_count') # Selecting shapes with their associated pokemon count
                       .group('shapes.id') # Grouping by shape id
                       .order('pokemon_count DESC') # Ordering by pokemon count in descending order
                       .page(params[:page]).per(15) # Pagination
    end

    # Method to show pokemons of a specific shape
    def show
        @shape = Shape.find(params[:id]) # Finding the shape by ID
        @pokemons = @shape.pokemons.page(params[:page]).per(15) # Retrieving pokemons associated with the shape with pagination
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false # Render custom 404 page if shape is not found
    end
end
