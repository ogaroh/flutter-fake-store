import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fake_store/data/repositories/wishlist_repository.dart';
import 'package:fake_store/presentation/state/wishlist/wishlist_event.dart';
import 'package:fake_store/presentation/state/wishlist/wishlist_state.dart';

@injectable
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository _wishlistRepository;

  WishlistBloc(this._wishlistRepository) : super(WishlistInitial()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
    on<ClearWishlist>(_onClearWishlist);
  }

  Future<void> _onLoadWishlist(
    LoadWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      final items = await _wishlistRepository.getWishlistItems();
      emit(WishlistLoaded(items));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onAddToWishlist(
    AddToWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      await _wishlistRepository.addToWishlist(event.item);
      final items = await _wishlistRepository.getWishlistItems();
      emit(WishlistLoaded(items));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      await _wishlistRepository.removeFromWishlist(event.productId);
      final items = await _wishlistRepository.getWishlistItems();
      emit(WishlistLoaded(items));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onClearWishlist(
    ClearWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      await _wishlistRepository.clearWishlist();
      emit(const WishlistLoaded([]));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
}
