class PokemonsController < ApplicationController
    # Method to retrieve a list of pokemons based on search and type filters
    def index
        @pokemons = Pokemon.all # Retrieve all pokemons by default

        # Apply search filter if present
        if params[:search].present?
            @pokemons = @pokemons.where("pokemons.name LIKE ?", "%#{params[:search]}%")
        end

        # Apply type filter if present
        if params[:type].present?
            @pokemons = @pokemons.joins(:types).where(types: { name: params[:type] })
        end

        @pokemons = @pokemons.page(params[:page]).per(15) # Pagination
    end

    # Method to show details of a specific pokemon
    def show
        @pokemon = Pokemon.find(params[:id]) # Finding the pokemon by ID
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false # Render custom 404 page if pokemon is not found
    end
end
