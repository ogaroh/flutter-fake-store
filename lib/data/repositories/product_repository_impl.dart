import 'package:injectable/injectable.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> fetchProducts({int limit = 10, int offset = 0}) async {
    final models = await remoteDataSource.fetchProducts(
      limit: limit,
      offset: offset,
    );
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Product> fetchProductDetails(int productId) async {
    final model = await remoteDataSource.fetchProductDetails(productId);
    return model.toEntity();
  }
}
