class PokemonsController < ApplicationController
    def index
        @pokemons = Pokemon.all

        if params[:search].present?
            @pokemons = @pokemons.where("pokemons.name LIKE ?", "%#{params[:search]}%")
        end

        if params[:type].present?
            @pokemons = @pokemons.joins(:types).where(types: { name: params[:type] })
        end

        @pokemons = @pokemons.page(params[:page]).per(15)
    end

    def show
        @pokemon = Pokemon.find(params[:id])
    end
end
