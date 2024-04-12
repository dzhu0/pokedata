class ShapesController < ApplicationController
    def index
        @shapes = Shape.all.sort_by { |shape| shape.pokemons.count }.reverse
    end

    def show
        @shape = Shape.find(params[:id])
        @pokemons = @shape.pokemons
    end
end
