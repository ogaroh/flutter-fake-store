# Fake Store App

A Flutter e-commerce application that demonstrates modern app architecture and state management patterns.

## Features

- **Product Browsing**

  - View list of products with images and details
  - Search and filter products
  - View detailed product information

- **Shopping Cart**

  - Add/remove products to cart
  - Adjust product quantities
  - Persistent cart state
  - Real-time total calculation

- **User Authentication**
  - Secure login system
  - Persistent session management
  - Protected routes

## Architecture

The app follows Clean Architecture principles with the following layers:

### Presentation Layer

- **Screens**: UI components organized by feature
- **Widgets**: Reusable UI components
- **State Management**: BLoC pattern for state management
  - Events: User actions and system events
  - States: UI states and data models
  - BLoCs: Business logic and state handling

### Domain Layer

- **Entities**: Core business objects
- **Repositories**: Abstract interfaces for data operations
- **Use Cases**: Business logic and rules

### Data Layer

- **Repositories**: Implementation of repository interfaces
- **Data Sources**: Local and remote data handling
- **Models**: Data transfer objects and mappers

## Technical Stack

- **Flutter**: UI framework
- **Dependency Injection**: GetIt + Injectable
- **State Management**: Flutter BLoC
- **Navigation**: Go Router
- **Local Storage**: Shared Preferences
- **API Client**: Dio
- **Code Generation**: Build Runner
- **Styling**: Custom theme with Material Design 3

## Project Structure

```
lib/
├── core/
│   ├── router/       # Navigation
│   ├── theme/        # App theme
│   ├── extensions/        # Extensions
│   └── utils/        # Utilities, theme, constants & color
├── data/
│   ├── models/       # Data models
│   ├── repositories/ # Repository implementations
│   └── sources/      # Data sources
├── domain/
│   ├── entities/     # Business objects
│   └── repositories/ # Repository interfaces
└── presentation/
    ├── screens/      # UI screens
    ├── state/        # BLoC states
    └── widgets/      # Reusable widgets
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:

```bash
git clone https://github.com/ogaroh/flutter-fake-store.git
```

or

```bash
git clone git@github.com:ogaroh/flutter-fake-store.git
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run code generation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Run the app:

```bash
flutter run --flavor dev --target lib/main_dev.dart
```

## State Management

The app uses the BLoC pattern for state management:

- **Events**: User actions (e.g., AddToCart, RemoveFromCart)
- **States**: UI states (e.g., CartLoading, CartLoaded)
- **BLoCs**: Business logic handling

Example:

```dart
// Event
class AddToCart extends CartEvent {
  final CartItem item;
  const AddToCart(this.item);
}

// State
class CartLoaded extends CartState {
  final List<CartItem> items;
  const CartLoaded(this.items);
}

// BLoC
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _repository;

  CartBloc(this._repository) : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
  }
}
```

## Dependency Injection

The app uses GetIt with Injectable for dependency injection:

- **Injectable**: Code generation for DI
- **GetIt**: Service locator
- **Module**: Configuration for external dependencies

## Testing

The app includes:

- Unit tests for business logic
- Widget tests for UI components
- Integration tests for features

Run tests:

```bash
flutter test
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

# Next steps
1. Wishlist management
