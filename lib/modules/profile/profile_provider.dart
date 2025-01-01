import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  int selectedTileIndex = 0;

  updateTileIndex(int index) {
    selectedTileIndex = index;
    notifyListeners();
  }
}
