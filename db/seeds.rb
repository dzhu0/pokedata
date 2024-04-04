require 'httparty'

Type.destroy_all

response = HTTParty.get('https://pokeapi.co/api/v2/type?limit=18')
data = JSON.parse(response.body)

data['results'].each do |type_data|
  Type.create(name: type_data['name'])
end

puts 'Table Types has been populated.'

Ability.destroy_all

response = HTTParty.get('https://pokeapi.co/api/v2/ability?limit=307')
data = JSON.parse(response.body)

data['results'].each do |ability_data|
  Ability.create(name: ability_data['name'])
end

puts 'Table Abilities has been populated.'

Pokemon.destroy_all

(1..1025).each do |pokemon_id|
  response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{pokemon_id}/")
  pokemon_data = JSON.parse(response.body)

  pokemon = Pokemon.create(
    name: pokemon_data['name'],
    weight: pokemon_data['weight'],
    height: pokemon_data['height'],
    image: pokemon_data['sprites']['front_default']
  )

  pokemon_data['types'].each do |type_data|
    type = Type.find_or_create_by(name: type_data['type']['name'])
    pokemon.types << type
  end

  pokemon_data['abilities'].each do |ability_data|
    ability = Ability.find_or_create_by(name: ability_data['ability']['name'])
    pokemon.abilities << ability
  end
end

puts 'Table Pokemons has been populated.'
