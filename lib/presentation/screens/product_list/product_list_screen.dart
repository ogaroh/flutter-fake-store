import 'package:fake_store/presentation/screens/product_list/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fake_store/injection.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Text(
              'Fake Store',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                final products =
                    state is ProductLoaded
                        ? state.products
                        : (state is ProductLoading)
                        ? state.previousProducts
                        : [];

                final isInitialLoading =
                    state is ProductLoading && (state.previousProducts.isEmpty);

                final hasReachedEnd =
                    state is ProductLoaded && state.hasReachedEnd;

                if (isInitialLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProductError && products.isEmpty) {
                  return Center(child: Text(state.message));
                }

                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    getIt<ProductBloc>().add(
                      const FetchProducts(loadMore: false),
                    );
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
                      return ProductCard(product: product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
