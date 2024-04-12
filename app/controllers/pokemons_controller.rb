class PokemonsController < ApplicationController
    def index
        @pokemons = Pokemon.page(params[:page]).per(15)
    end

    def show
        @pokemon = Pokemon.find(params[:id])
    end
end
