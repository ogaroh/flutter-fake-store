import 'package:fake_store/presentation/screens/login/login_screen.dart';
import 'package:fake_store/presentation/screens/login/welcome_screen.dart';
import 'package:fake_store/presentation/screens/product_details/product_details_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:fake_store/presentation//screens/product_list/product_list_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const WelcomeScreen()),
    GoRoute(path: '/welcome', builder: (_, __) => const WelcomeScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/products', builder: (_, __) => const ProductListScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final productId = state.pathParameters['id']!;
        return ProductDetailScreen(productId: int.parse(productId));
      },
    ),
  ],
);
