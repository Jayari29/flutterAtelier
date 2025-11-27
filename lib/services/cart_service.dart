import 'package:flutter/foundation.dart';
import '../models/firebase_models.dart';
import 'firebase_product_service.dart';

class CartItem {
  final FirebaseProduct product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartService with ChangeNotifier {
  final List<CartItem> _items = [];
  final ValueNotifier<double> _totalPrice = ValueNotifier<double>(0.0);
  final FirebaseProductService _productService = FirebaseProductService();

  List<CartItem> get items => List.unmodifiable(_items);
  ValueNotifier<double> get totalPriceNotifier => _totalPrice;

  void addProduct(FirebaseProduct product) {
    final idx = _items.indexWhere((i) => i.product.id == product.id);
    if (idx >= 0) {
      _items[idx].quantity += 1;
    } else {
      _items.add(CartItem(product: product));
    }
    _recalculate();
    notifyListeners();
  }

  void removeProduct(String productId) {
    _items.removeWhere((i) => i.product.id == productId);
    _recalculate();
    notifyListeners();
  }

  Future<void> checkout() async {
    // Example: decrement stock for each product in cart
    for (final item in _items) {
      await _productService.decrementStock(item.product.id, item.quantity);
    }
    _items.clear();
    _recalculate();
    notifyListeners();
  }

  void _recalculate() {
    double total = 0.0;
    for (final item in _items) {
      total += item.product.price * item.quantity;
    }
    _totalPrice.value = total;
  }
}
