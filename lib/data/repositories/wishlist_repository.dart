import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fake_store/data/models/wishlist_item.dart';

@injectable
class WishlistRepository {
  static const String _wishlistKey = 'wishlist_items';

  Future<List<WishlistItem>> getWishlistItems() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistJson = prefs.getString(_wishlistKey);
    if (wishlistJson == null) return [];

    final List<dynamic> decoded = json.decode(wishlistJson);
    return decoded.map((item) => WishlistItem.fromJson(item)).toList();
  }

  Future<void> saveWishlistItems(List<WishlistItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistJson = json.encode(
      items.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_wishlistKey, wishlistJson);
  }

  Future<void> addToWishlist(WishlistItem item) async {
    final items = await getWishlistItems();
    if (!items.any((i) => i.product.id == item.product.id)) {
      items.add(item);
      await saveWishlistItems(items);
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    final items = await getWishlistItems();
    items.removeWhere((item) => item.product.id == productId);
    await saveWishlistItems(items);
  }

  Future<bool> isInWishlist(int productId) async {
    final items = await getWishlistItems();
    return items.any((item) => item.product.id == productId);
  }

  Future<void> clearWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_wishlistKey);
  }
}
