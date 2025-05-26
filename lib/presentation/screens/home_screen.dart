import 'dart:developer';

import 'package:fake_store/core/extensions/extensions.dart';
import 'package:fake_store/core/utils/colors.dart';
import 'package:fake_store/data/datasources/local/shared_preferences_manager.dart';
import 'package:fake_store/injection.dart';
import 'package:fake_store/presentation/routes/app_router.dart';
import 'package:fake_store/presentation/state/auth/auth_bloc.dart';
import 'package:fake_store/presentation/state/auth/auth_event.dart';
import 'package:fake_store/presentation/state/auth/auth_state.dart';
import 'package:feather_icons/feather_icons.dart';
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
    // user name
    final user = getIt<SharedPreferencesManager>().getUser();
    final name = user?.username ?? 'username';
    final List<String> titles = [
      'Welcome,\n${name.capitalize}',
      'Wishlist',
      'Cart',
    ];

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        log("Listener: ${state.toString()}");
        if (state is AuthLogoutSuccess) {
          context.go(welcome);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            titles[_currentIndex],
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          actions: [
            InkWell(
              onTap: () {
                context.go(welcome);
                getIt<AuthBloc>().add(const AuthLogoutRequested());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    margin: EdgeInsets.only(bottom: 3),
                    child: Icon(
                      FeatherIcons.logOut,
                      color: AppColors.dark,
                      size: 20,
                    ),
                  ),
                  Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: AppColors.dark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
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
