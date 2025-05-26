import 'package:fake_store/data/models/product_model.dart';

class WishlistItem {
  final ProductModel product;

  WishlistItem({required this.product});

  Map<String, dynamic> toJson() => {'product': product.toJson()};

  factory WishlistItem.fromJson(Map<String, dynamic> json) =>
      WishlistItem(product: ProductModel.fromJson(json['product']));
}
