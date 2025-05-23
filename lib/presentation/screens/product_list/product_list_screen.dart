import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: const Center(child: Text('Products')),

      // return BlocProvider(
      //   create:
      //       (_) => ProductBloc(getIt())..add(const ProductEvent.fetchProducts()),
      //   child: Scaffold(
      //     appBar: AppBar(
      //       title: const Text('Products'),
      //       actions: [
      //         IconButton(
      //           onPressed: () {
      //             context.go('/counter');
      //           },
      //           icon: const Icon(Icons.add),
      //         ),
      //       ],
      //     ),
      // body: BlocBuilder<ProductBloc, ProductState>(
      //   builder: (context, state) {
      //     return state.when(
      //       initial: () => const Center(child: Text('Welcome')),
      //       loading: () => const Center(child: CircularProgressIndicator()),
      //       loaded:
      //           (products) => ListView.builder(
      //             itemCount: products.length,
      //             itemBuilder: (context, index) {
      //               final product = products[index];
      //               return ListTile(
      //                 leading: Image.network(
      //                   product.image,
      //                   width: 50,
      //                   height: 50,
      //                 ),
      //                 title: Text(product.title),
      //                 subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      //                 onTap: () => context.go('/product/${product.id}'),
      //               );
      //             },
      //           ),
      //       error: (message) => Center(child: Text(message)),
      //     );
      //   },
      // ),
    );
  }
}
