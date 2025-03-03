import 'package:flutter/material.dart';
import 'search_bottomsheet.dart';

void showSearchBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return const SearchBottomSheet();
    },
  );
}
