require 'httparty'

# Clearing existing data
Type.destroy_all
Ability.destroy_all
Pokemon.destroy_all
Shape.destroy_all

puts 'Populating Table Types.'

# Fetching data for Pokemon types
response = HTTParty.get('https://pokeapi.co/api/v2/type?limit=18')
data = JSON.parse(response.body)

# Populating the Types table
data['results'].each do |type_data|
  puts type_data['name']

  Type.create(name: type_data['name'])
end

puts 'Table Types has been populated.'

puts 'Populating Table Abilities.'

# Fetching data for Pokemon abilities
response = HTTParty.get('https://pokeapi.co/api/v2/ability?limit=307')
data = JSON.parse(response.body)

# Populating the Abilities table
data['results'].each do |ability_data|
  puts ability_data['name']

  Ability.create(name: ability_data['name'])
end

puts 'Table Abilities has been populated.'

puts 'Populating Table Shapes.'

# Fetching data for Pokemon shapes
response = HTTParty.get('https://pokeapi.co/api/v2/pokemon-shape')
data = JSON.parse(response.body)

# Populating the Shapes table
data['results'].each do |shape_data|
  puts shape_data['name']

  Shape.create(name: shape_data['name'])
end

puts 'Table Shapes has been populated.'

puts 'Populating Table Pokemons.'

# Populating the Pokemons table
(1..1025).each do |pokemon_id|
  puts pokemon_id

  # Fetching data for each Pokemon
  response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{pokemon_id}/")
  pokemon_data = JSON.parse(response.body)

  response = HTTParty.get("https://pokeapi.co/api/v2/pokemon-species/#{pokemon_id}/")
  pokemon_species_data = JSON.parse(response.body)

  # Finding the shape ID for the Pokemon
  shape_name = pokemon_species_data['shape']&.fetch('name', nil)
  shape_id = Shape.find_by(name: shape_name)&.id

  # Creating a new Pokemon entry
  pokemon = Pokemon.create(
    name: pokemon_data['name'],
    weight: pokemon_data['weight'],
    height: pokemon_data['height'],
    image: pokemon_data['sprites']['front_default'],
    shape_id: shape_id
  )

  # Adding types to the Pokemon
  pokemon_data['types'].each do |type_data|
    type = Type.find_or_create_by(name: type_data['type']['name'])
    pokemon.types << type
  end

  # Adding abilities to the Pokemon
  pokemon_data['abilities'].each do |ability_data|
    ability = Ability.find_or_create_by(name: ability_data['ability']['name'])
    pokemon.abilities << ability
  end
end

puts 'Table Pokemons has been populated.'
