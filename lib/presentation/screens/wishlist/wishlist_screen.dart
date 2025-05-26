import 'package:fake_store/presentation/screens/product_list/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/presentation/state/wishlist/wishlist_bloc.dart';
import 'package:fake_store/presentation/state/wishlist/wishlist_event.dart';
import 'package:fake_store/presentation/state/wishlist/wishlist_state.dart';
import 'package:get_it/get_it.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<WishlistBloc>()..add(LoadWishlist()),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<WishlistBloc, WishlistState>(
              builder: (context, state) {
                if (state is WishlistLoaded && state.items.isNotEmpty) {
                  return IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Clear Wishlist'),
                              content: const Text(
                                'Are you sure you want to clear your wishlist?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<WishlistBloc>().add(
                                      ClearWishlist(),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Clear'),
                                ),
                              ],
                            ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WishlistLoaded) {
              if (state.items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your wishlist is empty',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add items to your wishlist to see them here',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ProductCard(product: item.product.toEntity());
                },
              );
            } else if (state is WishlistError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading wishlist',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
