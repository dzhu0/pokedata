class AbilitiesController < ApplicationController
    # Method to retrieve a list of abilities with the count of associated pokemons
    def index
        @abilities = Ability.left_joins(:pokemons) # Left join to include abilities without pokemons
                            .select('abilities.*, COUNT(pokemons.id) AS pokemon_count') # Selecting abilities with their associated pokemon count
                            .group('abilities.id') # Grouping by ability id
                            .order('pokemon_count DESC') # Ordering by pokemon count in descending order
                            .page(params[:page]).per(15) # Pagination
    end

    # Method to show pokemons of a specific ability
    def show
        @ability = Ability.find(params[:id]) # Finding the ability by ID
        @pokemons = @ability.pokemons.page(params[:page]).per(15) # Retrieving pokemons associated with the ability with pagination
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false # Render custom 404 page if ability is not found
    end
end
