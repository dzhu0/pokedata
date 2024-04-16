# PokeData Rails Application

This is a Ruby on Rails web application for exploring Pokemon data. It provides functionalities to browse and search for different types of Pokemon, their abilities, shapes, and more.

## Features

- **Pokemon Index:** View a list of all Pokemon with pagination support.
- **Search:** Search for Pokemon by name.
- **Filter by Type:** Filter Pokemon by their type.
- **Pokemon Details:** View detailed information about each Pokemon, including its abilities, type, shape, weight, and height.
- **Ability Index:** Explore different abilities and see the number of Pokemon possessing each ability.
- **Shape Index:** Browse Pokemon shapes and see the number of Pokemon belonging to each shape.

## Setup

To run this project locally, follow these steps:

1. **Clone the repository:**

    ```bash
    git clone https://github.com/dzhu0/pokedata
    cd pokedata
    ```

2. **Install dependencies:**

    ```bash
    bundle install && npm ci && npm run build && npm run build:css
    ```

3. **Set up the database:**

    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

    This will create the necessary database schema and seed the database with Pokemon, types, abilities, and shapes data.

4. **Start the Rails server:**

    ```bash
    rails server
    ```

    The application should now be running at `http://localhost:3000`.

## Usage

- Visit `http://localhost:3000` to see the list of all Pokemon.
- Use the search bar to search for Pokemon by name.
- Use the filter dropdown to filter Pokemon by type.
- Click on a Pokemon to view its detailed information.
- Explore abilities and shapes using the respective links in the navigation bar.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the [LICENSE.md](LICENSE.md).
