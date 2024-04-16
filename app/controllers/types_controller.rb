class TypesController < ApplicationController
    # Method to retrieve a list of types with the count of associated pokemons
    def index
        @types = Type.left_joins(:pokemons) # Left join to include types without pokemons
                     .select('types.*, COUNT(pokemons.id) AS pokemon_count') # Selecting types with their associated pokemon count
                     .group('types.id') # Grouping by type id
                     .order('pokemon_count DESC') # Ordering by pokemon count in descending order
                     .page(params[:page]).per(15) # Pagination
    end

    # Method to show pokemons of a specific type
    def show
        @type = Type.find(params[:id]) # Finding the type by ID
        @pokemons = @type.pokemons.page(params[:page]).per(15) # Retrieving pokemons associated with the type with pagination
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false # Render custom 404 page if type is not found
    end
end
