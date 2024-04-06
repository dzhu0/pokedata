class Shape < ApplicationRecord
    has_many :pokemons

    validates :name, presence: true, uniqueness: true
end
