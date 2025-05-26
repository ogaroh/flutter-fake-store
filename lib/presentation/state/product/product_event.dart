import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductEvent {
  final bool loadMore;

  const FetchProducts({this.loadMore = false});
}

class FetchProductDetails extends ProductEvent {
  final int productId;

  const FetchProductDetails(this.productId);

  @override
  List<Object?> get props => [productId];
}
