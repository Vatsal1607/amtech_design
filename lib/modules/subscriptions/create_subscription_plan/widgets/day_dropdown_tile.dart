import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaySelectionDropdown extends StatefulWidget {
  const DaySelectionDropdown({super.key});

  @override
  State<DaySelectionDropdown> createState() => _DaySelectionDropdownState();
}

class _DaySelectionDropdownState extends State<DaySelectionDropdown> {
  bool isExpanded = false;
  String? selectedTime = "10:00AM To 11:00AM";
  String? selectedMeal = "Exotic Fruit Salad";

  final List<String> timeSlots = [
    "08:00AM To 09:00AM",
    "10:00AM To 11:00AM",
    "12:00PM To 01:00PM"
  ];
  final List<String> mealOptions = [
    "Exotic Fruit Salad",
    "Veggie Wrap",
    "Pasta Bowl"
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Keeps the "data" below the dropdown in the same place
        Column(
          children: [
            SizedBox(
              height: 60.h,
              width: 280.w,
            ), // Space for dropdown area
            // const Text(
            //   "Below Content (Static)",
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              // Header (Monday Dropdown Button)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00204A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Monday",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded Dropdown Content (Overlays Below Text)
              if (isExpanded)
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00204A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildDropdown(
                            "Select Time Slot", selectedTime, timeSlots,
                            (value) {
                          // Prevents closing the main dropdown when interacting with this one
                          // FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            selectedTime = value;
                            log('Selected time slot $value');
                          });
                        }),

                        _buildDropdown("Select Meal", selectedMeal, mealOptions,
                            (value) {
                          // Prevents closing the main dropdown when interacting with this one
                          // FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            selectedMeal = value;
                          });
                        }),

                        const Divider(color: Colors.white, thickness: 0.5),

                        // Add New Meal Button
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.add,
                                color: Colors.white, size: 16),
                            label: const Text("ADD NEW MEAL",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String? selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              value: selectedValue,
              isExpanded: true,
              dropdownStyleData: const DropdownStyleData(
                elevation: 8,
                useSafeArea: true, // Prevents dismissing the parent dropdown
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              onChanged: onChanged,
              buttonStyleData: ButtonStyleData(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
              ),
              items: options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child:
                      Text(option, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
