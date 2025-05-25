import 'dart:developer';

import 'package:fake_store/presentation/routes/app_router.dart';
import 'package:fake_store/presentation/state/auth/auth_bloc.dart';
import 'package:fake_store/presentation/state/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:fake_store/presentation/screens/product_list/product_list_screen.dart';
import 'package:fake_store/presentation/screens/wishlist/wishlist_screen.dart';
import 'package:fake_store/presentation/screens/cart/cart_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ProductListScreen(),
    const WishlistScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        log("Listener: ${state.toString()}");
        if (state is AuthLogoutSuccess) {
          context.go(welcome);
        }
      },
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
        ),
      ),
    );
  }
}
