import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fake_store/data/models/cart_item.dart';

@injectable
class CartRepository {
  static const String _cartKey = 'cart_items';

  Future<List<CartItem>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey);
    if (cartJson == null) return [];

    final List<dynamic> decoded = json.decode(cartJson);
    return decoded.map((item) => CartItem.fromJson(item)).toList();
  }

  Future<void> saveCartItems(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = json.encode(items.map((item) => item.toJson()).toList());
    await prefs.setString(_cartKey, cartJson);
  }

  Future<void> addToCart(CartItem item) async {
    final items = await getCartItems();
    final existingIndex = items.indexWhere(
      (i) => i.product.id == item.product.id,
    );

    if (existingIndex >= 0) {
      items[existingIndex].quantity += item.quantity;
    } else {
      items.add(item);
    }

    await saveCartItems(items);
  }

  Future<void> removeFromCart(int productId) async {
    final items = await getCartItems();
    items.removeWhere((item) => item.product.id == productId);
    await saveCartItems(items);
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    final items = await getCartItems();
    final index = items.indexWhere((item) => item.product.id == productId);

    if (index >= 0) {
      if (quantity <= 0) {
        items.removeAt(index);
      } else {
        items[index].quantity = quantity;
      }
      await saveCartItems(items);
    }
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
