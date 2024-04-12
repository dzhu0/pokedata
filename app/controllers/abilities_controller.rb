class AbilitiesController < ApplicationController
    def index
        @abilities = Ability.all.sort_by { |ability| ability.pokemons.count }.reverse
    end

    def show
        @ability = Ability.find(params[:id])
        @pokemons = @ability.pokemons
    end
end
  