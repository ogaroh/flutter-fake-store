![Screenshot_1748248824](https://github.com/user-attachments/assets/0771f829-731c-4faa-b7cb-22fab52494ae)![Screenshot_1748253879](https://github.com/user-attachments/assets/ccdc4efe-e5eb-4121-888c-1bbcf893f3b4)![Screenshot_1748254515](https://github.com/user-attachments/assets/b45df6a5-e7e1-47dc-9d50-80c94bb1734f)![Screenshot_1748242559](https://github.com/user-attachments/assets/15ca6b5d-70ba-406d-b802-434e7a700b64)# Fake Store App

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


# Screenshots
1. Welcome
  ![Screenshot_1748242559](https://github.com/user-attachments/assets/9b0fe1c8-5265-408b-9812-f174bb09e333)

2. Login
![Screenshot_1748254515](https://github.com/user-attachments/assets/3ff2dd5d-f598-4f4b-b6bc-5e844743595c)
![Screenshot_1748254550](https://github.com/user-attachments/assets/1163115d-5358-463a-8bc9-e4e4271d022c)

3. Product list
![Screenshot_1748253879](https://github.com/user-attachments/assets/53c632a1-145b-4d0d-9049-bfe67fa1a8f4)

4. Product details
![Screenshot_1748253881](https://github.com/user-attachments/assets/8b306bab-1b93-4ad1-adce-071e2e958534)
![Screenshot_1748248824](https://github.com/user-attachments/assets/5153dc19-cedf-4ce2-b92d-305ffb9124c3)

5. Cart
![Screenshot_1748253875](https://github.com/user-attachments/assets/ca9a0d92-6a9f-4ca0-a746-72f9da534785)


