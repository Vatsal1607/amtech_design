import 'package:amtech_design/core/utils/strings.dart';
import 'package:flutter/material.dart';

class RatingsProvider extends ChangeNotifier {
  int currentIndex = 0;

  final List<Map<String, dynamic>> items = [
    {
      'image': ImageStrings.masalaTea2,
      'title': 'Masala Tea',
    },
    {
      'image': ImageStrings.masalaTea2,
      'title': 'Ginger Tea',
    },
    {
      'image': ImageStrings.masalaTea2,
      'title': 'Cardamom Tea',
    },
  ];

  onPageChanged(index, reason) {
    currentIndex = index;
    notifyListeners();
  }
}
