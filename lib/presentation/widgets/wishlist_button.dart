import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/data/models/product_model.dart';
import 'package:fake_store/data/models/wishlist_item.dart';
import 'package:fake_store/presentation/state/wishlist/wishlist_bloc.dart';
import 'package:fake_store/presentation/state/wishlist/wishlist_event.dart';
import 'package:fake_store/presentation/state/wishlist/wishlist_state.dart';

class WishlistButton extends StatelessWidget {
  final ProductModel product;

  const WishlistButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      builder: (context, state) {
        if (state is WishlistLoaded) {
          final isInWishlist = state.items.any(
            (item) => item.product.id == product.id,
          );
          return IconButton(
            icon: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: isInWishlist ? Colors.red : null,
            ),
            onPressed: () {
              if (isInWishlist) {
                context.read<WishlistBloc>().add(
                  RemoveFromWishlist(product.id),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Removed from wishlist')),
                );
              } else {
                context.read<WishlistBloc>().add(
                  AddToWishlist(WishlistItem(product: product)),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to wishlist')),
                );
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
