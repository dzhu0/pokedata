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
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
end
