import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  bool isExpanded = false;
  onExpansionChanged(value) {
    isExpanded = value;
    notifyListeners();
  }
}
