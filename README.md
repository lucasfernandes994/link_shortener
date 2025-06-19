# Link Shortener App

A cross-platform link shortener application built with Flutter and Dart, featuring a clean
architecture and unit-tested business logic.

## Important Note
The "url-shortener-nu.herokuapp.com" given is not working, I created a mock server API to test the app.
Please, go to the constant file `src/home/data/constants.dart` and change the `BASE_URL` to your own API endpoint.

## Features

- Shorten URLs via a remote API
- View and manage a list of recently shortened links
- Remove aliases from local storage
- Error handling and user feedback
- Unit and widget tests for core functionality

## Tech Stack

- **Flutter** (UI)
- **Dart** (business logic)
- **mocktail** (testing/mocking)
- **http** (network requests)
- **value notifier** (state management)
- **shared_preferences** (local storage)
- **clean architecture** (project structure)
- **dartz** (functional programming utilities)
- **equatable** (value equality)

## Project Architecture

The project follows a clean architecture pattern, separating concerns into distinct layers:

- **Presentation Layer**: Contains UI components, controllers, and state management.
- **Domain Layer**: Contains business logic, entities, and use cases.
- **Data Layer**: Contains data sources, repositories, and models for API interaction.
- **Testing Layer**: Contains unit and widget tests to ensure code quality and reliability.

## Project Structure

- `src/home/presenter/` — UI, controllers, and state management
- `src/home/domain/` — Entities and use cases
- `src/home/data/` — Data sources and repositories
- `test/` — Unit and widget tests

## Running the App

1. Install dependencies:
2. Run the app:

## Running Tests

make run-unit-tests

## Contributing

Pull requests are welcome. For major changes, please open an issue first.

## License

[MIT](LICENSE)

