import 'package:injectable/injectable.dart';
import '../../models/product_model.dart';
import '../../../core/network/dio_client.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts({int limit, int offset});
  Future<ProductModel> fetchProductDetails(int productId);
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<ProductModel>> fetchProducts({
    int limit = 100,
    int offset = 0,
  }) async {
    final response = await dioClient.dio.get(
      '/products',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final List data = response.data;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<ProductModel> fetchProductDetails(int productId) async {
    final response = await dioClient.dio.get('/products/$productId');
    return ProductModel.fromJson(response.data);
  }
}
