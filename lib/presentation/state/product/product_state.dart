import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  final List<Product> previousProducts;
  const ProductLoading({this.previousProducts = const []});
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasReachedEnd;
  const ProductLoaded(this.products, {this.hasReachedEnd = false});
}

class ProductDetailsLoaded extends ProductState {
  final Product product;

  const ProductDetailsLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
