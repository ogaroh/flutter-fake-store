import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/repositories/product_repository.dart';

part 'product_bloc.freezed.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.fetchProducts() = _FetchProducts;
}

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded(List<Product> products) = _Loaded;
  const factory ProductState.error(String message) = _Error;
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(const _Initial()) {
    on<_FetchProducts>((event, emit) async {
      emit(const _Loading());
      try {
        final products = await repository.fetchProducts();
        emit(_Loaded(products));
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}
