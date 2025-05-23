import 'package:fake_store/data/datasources/local/shared_preferences_manager.dart';
import 'package:fake_store/injection.dart';
import 'package:fake_store/presentation/screens/home_screen.dart';
import 'package:fake_store/presentation/screens/login/login_screen.dart';
import 'package:fake_store/presentation/screens/login/welcome_screen.dart';
import 'package:fake_store/presentation/screens/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fake_store/presentation//screens/product_list/product_list_screen.dart';

// navigator key
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

// paths
final String home = '/home';
final String products = '$home/products';
final String productDetails = '$home/product/:id';
final String login = '/login';
final String welcome = '/welcome';

final GoRouter routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (context, state) {
    final isLoggedIn = getIt<SharedPreferencesManager>().isLoggedIn();
    final isLoginRoute = state.matchedLocation == login;
    final isWelcomeRoute = state.matchedLocation == welcome;

    // If user is not logged in and not on login/welcome page, redirect to login
    if (!isLoggedIn && !isLoginRoute && !isWelcomeRoute) {
      return login;
    }

    // If user is logged in and on login/welcome page, redirect to products
    if (isLoggedIn && (isLoginRoute || isWelcomeRoute)) {
      return home;
    }

    // No redirection needed
    return null;
  },
  routes: [
    GoRoute(path: '/', redirect: (_, __) => home),
    GoRoute(path: login, builder: (_, __) => const LoginScreen()),
    GoRoute(path: welcome, builder: (_, __) => const WelcomeScreen()),
    GoRoute(
      path: home,
      builder: (_, __) => const HomeScreen(),
      routes: [
        GoRoute(path: products, builder: (_, __) => const ProductListScreen()),
        GoRoute(
          path: productDetails,
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return ProductDetailScreen(productId: int.parse(productId));
          },
        ),
      ],
    ),
  ],
);
