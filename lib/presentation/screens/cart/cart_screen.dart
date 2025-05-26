import 'package:fake_store/core/utils/colors.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/data/models/cart_item.dart';
import 'package:fake_store/presentation/state/cart/cart_bloc.dart';
import 'package:fake_store/presentation/state/cart/cart_event.dart';
import 'package:fake_store/presentation/state/cart/cart_state.dart';
import 'package:fake_store/presentation/widgets/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import '../../../injection.dart';

@injectable
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartBloc>()..add(LoadCart()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Cart'),
          actions: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded && state.items.isNotEmpty) {
                  return IconButton(
                    tooltip: 'Clear Cart',
                    icon: const Icon(FeatherIcons.trash2, color: AppColors.red),
                    onPressed: () {
                      context.read<CartBloc>().add(ClearCart());
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              if (state.items.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return CartItemWidget(item: item);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Cart Total:',
                                style: TextStyle(
                                  color: AppColors.dark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '\$${state.total.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: AppColors.dark,
                                  fontFamily: GoogleFonts.lora().fontFamily,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        AppButton(
                          width: 250,
                          label: 'Checkout',
                          onPressed: () {
                            // TODO: Implement checkout
                          },
                          type: AppButtonType.dark,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // swipe to remove item

    return Dismissible(
      key: Key(item.product.id.toString()),
      onDismissed: (direction) {
        context.read<CartBloc>().add(RemoveFromCart(item.product.id));
      },
      background: Container(
        color: AppColors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(FeatherIcons.trash2, color: AppColors.white),
          ),
        ),
      ),
      child: Card(
        elevation: 0.1,
        color: AppColors.greyFill,
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  item.product.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.greyLight1,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              if (item.quantity > 1) {
                                context.read<CartBloc>().add(
                                  UpdateQuantity(
                                    item.product.id,
                                    item.quantity - 1,
                                  ),
                                );
                              } else {
                                context.read<CartBloc>().add(
                                  RemoveFromCart(item.product.id),
                                );
                              }
                            },
                          ),
                          VerticalDivider(
                            color: AppColors.greyLight1,
                            thickness: 1.5,
                          ),

                          Text(
                            item.quantity.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          VerticalDivider(
                            color: AppColors.greyLight1,
                            thickness: 1.5,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline_outlined),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                UpdateQuantity(
                                  item.product.id,
                                  item.quantity + 1,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '\$${item.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
