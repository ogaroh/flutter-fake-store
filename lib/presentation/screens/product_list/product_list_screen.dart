import 'package:fake_store/presentation/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:fake_store/injection.dart';
import 'package:fake_store/presentation/state/auth/auth_bloc.dart';
import 'package:fake_store/presentation/state/auth/auth_event.dart';
import 'package:fake_store/presentation/state/product/product_bloc.dart';
import 'package:fake_store/presentation/state/product/product_event.dart';
import 'package:fake_store/presentation/state/product/product_state.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    getIt<ProductBloc>().add(const FetchProducts()); // Initial fetch
  }

  void _onScroll() {
    final bloc = getIt<ProductBloc>();
    final state = bloc.state;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        state is ProductLoaded &&
        !state.hasReachedEnd) {
      bloc.add(const FetchProducts(loadMore: true));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          FilledButton.icon(
            onPressed: () {
              context.go(welcome);
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
          final products =
              state is ProductLoaded
                  ? state.products
                  : (state is ProductLoading && state.previousProducts != null)
                  ? state.previousProducts!
                  : [];

          final isInitialLoading =
              state is ProductLoading && (state.previousProducts.isEmpty);

          final isLoadingMore =
              state is ProductLoading && (state.previousProducts.isNotEmpty);

          final hasReachedEnd = state is ProductLoaded && state.hasReachedEnd;

          if (isInitialLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductError && products.isEmpty) {
            return Center(child: Text(state.message));
          }

          return RefreshIndicator.adaptive(
            onRefresh: () async {
              getIt<ProductBloc>().add(const FetchProducts(loadMore: false));
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: products.length + (hasReachedEnd ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= products.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final product = products[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.description),
                  onTap: () => context.go('/home/product', extra: product.id),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
