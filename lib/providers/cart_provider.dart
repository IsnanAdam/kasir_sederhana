import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<Product, int> _items = {};

  Map<Product, int> get items => _items;

  void addToCart(Product product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    if (_items.containsKey(product)) {
      if (_items[product]! > 1) {
        _items[product] = _items[product]! - 1;
      } else {
        _items.remove(product);
      }
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get totalItems => _items.length;

  int get totalPrice {
    int total = 0;
    _items.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  int quantityOf(Product product) => _items[product] ?? 0;
}
