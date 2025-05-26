import 'package:fake_store/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts({int limit = 100, int offset = 0});

  Future<Product> fetchProductDetails(int productId);
}
