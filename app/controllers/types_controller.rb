class TypesController < ApplicationController
    def index
        @types = Type.all.sort_by { |type| type.pokemons.count }.reverse
    end

    def show
        @type = Type.find(params[:id])
        @pokemons = @type.pokemons
    end
end
