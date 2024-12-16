import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartProvider extends ChangeNotifier {
  bool isExpanded = false;
  onExpansionChanged(value) {
    isExpanded = value;
    notifyListeners();
  }

  double dragPosition = 10.w; // Track the drag position
  final double maxDrag = 280.w; // Maximum drag length
  // maxDrag parentWidth - buttonWidth - 10.0;
  final minDrag = 10.w;
  bool isConfirmed = false; // Track if the action is confirmed

  // * New gesture effect
  // void onHorizontalDragUpdate(DragUpdateDetails details) {
  //   dragPosition += details.delta.dx; // Update drag position
  //   if (dragPosition < 10.w) dragPosition = 10.w; // Keep within bounds
  //   if (dragPosition > maxDrag) dragPosition = maxDrag; // Keep within bounds
  //   notifyListeners();
  // }

  // void onHorizontalDragEnd(DragEndDetails details) {
  //   if (dragPosition >= maxDrag * 0.8) {
  //     debugPrint('Order Confirmed');
  //   }
  //   dragPosition = 10.w; // Reset position after release
  //   notifyListeners();
  // }

  // * old gesture effect
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    dragPosition += details.delta.dx;
    // Prevent sliding left
    if (dragPosition < 0) {
      dragPosition = 10.w;
    }
    // Limit max drag
    if (dragPosition > maxDrag) {
      dragPosition = maxDrag;
    }
    notifyListeners(); // Notify listeners of the change
  }

  void onHorizontalDragEnd(details) {
    if (dragPosition >= maxDrag * 0.8) {
      // Action confirmed
      isConfirmed = true;
      dragPosition = maxDrag; // Snap to the end

      debugPrint("Order Placed!");
    } else {
      // Reset position
      dragPosition = 10.w;
      isConfirmed = false;
    }

    notifyListeners(); // Notify listeners of the change
  }
}
