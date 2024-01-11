import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  int _cartCount = 0;

  int get cartCount => _cartCount;

  void addToCart(int quantity) {
    _cartCount += quantity;
    notifyListeners();
  }

  void updateCart() {
    notifyListeners(); 
  }
}
