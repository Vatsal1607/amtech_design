// class SelectedMeal {
//   final String menuId;
//   final String itemName;
//   final int quantity;
//   final String? sizeId;
//   final String? sizeName;
//   final int? price;
//   final String day;
//   final String timeSlot;
//   final Map<String, bool> selectedIngredients;
//   final Map<String, int> selectedAddOns;

//   SelectedMeal({
//     required this.menuId,
//     required this.itemName,
//     required this.quantity,
//     this.sizeId,
//     this.sizeName,
//     this.price,
//     required this.day,
//     required this.timeSlot,
//     required this.selectedIngredients,
//     required this.selectedAddOns,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'menuId': menuId,
//       'itemName': itemName,
//       'quantity': quantity,
//       'sizeId': sizeId,
//       'sizeName': sizeName,
//       'price': price,
//       'day': day,
//       'timeSlot': timeSlot,
//       'selectedIngredients': selectedIngredients,
//       'selectedAddOns': selectedAddOns,
//     };
//   }
// }


// // class SelectedMeal {
// //   final String menuId;
// //   final String itemName;
// //   int quantity;
// //   final Map<String, bool> selectedIngredients;
// //   final Map<String, int> selectedAddOns; // Add-ons can have a quantity

// //   SelectedMeal({
// //     required this.menuId,
// //     required this.itemName,
// //     this.quantity = 1,
// //     required this.selectedIngredients,
// //     required this.selectedAddOns,
// //   });

// //   Map<String, dynamic> toJson() {
// //     return {
// //       "menuId": menuId,
// //       "itemName": itemName,
// //       "quantity": quantity,
// //       "selectedIngredients": selectedIngredients.keys
// //           .where((key) => selectedIngredients[key] == true)
// //           .toList(),
// //       "selectedAddOns":
// //           selectedAddOns.map((key, value) => MapEntry(key, value)),
// //     };
// //   }
// // }
