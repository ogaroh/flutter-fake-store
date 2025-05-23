import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: const Center(child: Text('Product Details')),
    );
    // return BlocProvider(
    //   create:
    //       (_) => ProductBloc(getIt())..add(const ProductEvent.fetchProducts()),
    //   child: Scaffold(
    //     appBar: AppBar(title: const Text('Product Details')),
    //     // body: BlocBuilder<ProductBloc, ProductState>(
    //     //   builder: (context, state) {
    //     //     return state.when(
    //     //       initial: () => const Center(child: Text('Loading...')),
    //     //       loading: () => const Center(child: CircularProgressIndicator()),
    //     //       loaded: (products) {
    //     //         final product = products.firstWhere((p) => p.id == productId);
    //     //         return Padding(
    //     //           padding: const EdgeInsets.all(16.0),
    //     //           child: Column(
    //     //             crossAxisAlignment: CrossAxisAlignment.start,
    //     //             children: [
    //     //               Image.network(product.image, height: 200),
    //     //               const SizedBox(height: 16),
    //     //               Text(
    //     //                 product.title,
    //     //                 style: const TextStyle(
    //     //                   fontSize: 24,
    //     //                   fontWeight: FontWeight.bold,
    //     //                 ),
    //     //               ),
    //     //               const SizedBox(height: 8),
    //     //               Text(
    //     //                 '\$${product.price.toStringAsFixed(2)}',
    //     //                 style: const TextStyle(fontSize: 20),
    //     //               ),
    //     //               const SizedBox(height: 8),
    //     //               Text('Category: ${product.category}'),
    //     //               const SizedBox(height: 8),
    //     //               Text('Rating: ${product.rating}'),
    //     //               const SizedBox(height: 16),
    //     //               Text(product.description),
    //     //               const SizedBox(height: 16),
    //     //               ElevatedButton(
    //     //                 onPressed: () {
    //     //                   // Add to cart functionality
    //     //                 },
    //     //                 child: const Text('Add to Cart'),
    //     //               ),
    //     //             ],
    //     //           ),
    //     //         );
    //     //       },
    //     //       error: (message) => Center(child: Text(message)),
    //     //     );
    //     //   },
    //     // ),
    //   ),
    // );
  }
}
