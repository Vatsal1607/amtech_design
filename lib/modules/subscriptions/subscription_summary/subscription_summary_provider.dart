import 'package:flutter/material.dart';

class SubscriptionSummaryProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> subscriptionDetails = [
    {
      'day': 'Monday',
      'timeslots': [
        {
          'time': '10:00AM To 11:00AM',
          'item': 'Kachumber Salad',
          'description':
              'Cucumber, Tomato, Onion, Cilantro, Carrot, Cabbage, Mint Leaves crafted with the Indian Spices'
        },
        {
          'time': '04:00PM To 05:00PM',
          'item': 'Protein Salad',
          'description':
              'Roasted Peanuts, Boiled grains, Paneer, Fresh Vegetables crafted with the Olive Oil and curd Dressing | 1 Apple Juice'
        },
      ]
    },
    {
      'day': 'Tuesday',
      'timeslots': [
        {
          'time': '10:00AM To 11:00AM',
          'item': 'Kachumber Salad',
          'description':
              'Cucumber, Tomato, Onion, Cilantro, Carrot, Cabbage, Mint Leaves crafted with the Indian Spices'
        },
      ]
    },
    {
      'day': 'Wednesday',
      'timeslots': [
        {
          'time': '10:00AM To 11:00AM',
          'item': 'Kachumber Salad',
          'description':
              'Cucumber, Tomato, Onion, Cilantro, Carrot, Cabbage, Mint Leaves crafted with the Indian Spices'
        },
      ]
    },
    // * Add other days similarly
  ];
}
