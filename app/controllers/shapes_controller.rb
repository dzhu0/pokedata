class ShapesController < ApplicationController
    def index
        @shapes = Shape.left_joins(:pokemons)
                        .select('shapes.*, COUNT(pokemons.id) AS pokemon_count')
                        .group('shapes.id')
                        .order('pokemon_count DESC')
                        .page(params[:page]).per(15)
    end

    def show
        @shape = Shape.find(params[:id])
        @pokemons = @shape.pokemons.page(params[:page]).per(15)
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
end
