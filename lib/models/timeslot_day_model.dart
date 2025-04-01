class TimeSlotDayModel {
  String selectedTimeSlot;
  List<MealModel> meals;

  TimeSlotDayModel({
    required this.selectedTimeSlot,
    required this.meals,
  });
}

class MealModel {
  String mealName;
  int quantity; // Min 1

  MealModel({
    required this.mealName,
    this.quantity = 1, // Default min quantity
  });
}
