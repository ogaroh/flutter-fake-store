import 'package:equatable/equatable.dart';
import 'package:fake_store/data/models/wishlist_item.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWishlist extends WishlistEvent {}

class AddToWishlist extends WishlistEvent {
  final WishlistItem item;

  const AddToWishlist(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveFromWishlist extends WishlistEvent {
  final int productId;

  const RemoveFromWishlist(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ClearWishlist extends WishlistEvent {}
