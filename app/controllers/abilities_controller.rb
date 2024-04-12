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
    end
end
  