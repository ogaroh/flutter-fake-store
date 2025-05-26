import 'package:fake_store/domain/entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(const ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchProductDetails>(_onFetchProductDetails);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    List<Product> currentProducts = [];

    // Preserve existing products if loading more
    if (event.loadMore && state is ProductLoaded) {
      currentProducts = (state as ProductLoaded).products;
      emit(ProductLoading(previousProducts: currentProducts));
    } else {
      emit(const ProductLoading());
    }

    try {
      final offset = currentProducts.length;
      final newProducts = await repository.fetchProducts(
        limit: 100,
        offset: offset,
      );

      final allProducts = [...currentProducts, ...newProducts];
      final hasReachedEnd = newProducts.isEmpty;

      emit(ProductLoaded(allProducts, hasReachedEnd: hasReachedEnd));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onFetchProductDetails(
    FetchProductDetails event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    try {
      final product = await repository.fetchProductDetails(event.productId);
      emit(ProductDetailsLoaded(product));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
