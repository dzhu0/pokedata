class TypesController < ApplicationController
    def index
        @types = Type.left_joins(:pokemons)
                     .select('types.*, COUNT(pokemons.id) AS pokemon_count')
                     .group('types.id')
                     .order('pokemon_count DESC')
                     .page(params[:page]).per(15)
    end

    def show
        @type = Type.find(params[:id])
        @pokemons = @type.pokemons.page(params[:page]).per(15)
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
end
