class AbilitiesController < ApplicationController
    def index
        @abilities = Ability.left_joins(:pokemons)
                            .select('abilities.*, COUNT(pokemons.id) AS pokemon_count')
                            .group('abilities.id')
                            .order('pokemon_count DESC')
                            .page(params[:page]).per(15)
    end

    def show
        @ability = Ability.find(params[:id])
        @pokemons = @ability.pokemons.page(params[:page]).per(15)
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
end
  