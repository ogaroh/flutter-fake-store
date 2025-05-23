import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:fake_store/injection.dart';
import 'package:fake_store/presentation/state/auth/auth_bloc.dart';
import 'package:fake_store/presentation/state/auth/auth_event.dart';
import 'package:fake_store/presentation/state/product/product_bloc.dart';
import 'package:fake_store/presentation/state/product/product_event.dart';
import 'package:fake_store/presentation/state/product/product_state.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          FilledButton.icon(
            onPressed: () async {
              context.go('/login');
              getIt<AuthBloc>().add(const AuthLogoutRequested());
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                getIt<ProductBloc>().add(const FetchProducts());
              },
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text(product.description),
                    onTap: () {
                      context.push('/home/product/${product.id}');
                    },
                  );
                },
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
