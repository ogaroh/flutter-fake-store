// ignore_for_file: deprecated_member_use

import 'package:fake_store/core/utils/colors.dart';
import 'package:fake_store/domain/entities/product.dart';
import 'package:fake_store/presentation/widgets/snackbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.greyLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () => context.go('/home/product', extra: product.id),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      product.description,
                      style: TextStyle(fontSize: 12, color: AppColors.grey),
                      maxLines: 2,
                    ),
                    // rating
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.dark, size: 14),
                        SizedBox(width: 5),
                        Text(
                          product.rating.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.dark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    // price
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // add / remove from wishlist shared preferences
              IconButton(
                onPressed: () {
                  CustomSnackbar.show(context, 'Wishlist coming soon...');
                },
                icon: Icon(FeatherIcons.heart, color: AppColors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
