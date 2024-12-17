import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RechargeProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  final NumberFormat _indianFormat = NumberFormat('#,##,##,###', 'en_IN');

  RechargeProvider() {
    amountController.addListener(() {
      _formatIndianNumber(amountController.text);
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _formatIndianNumber(String value) {
    if (value.isEmpty) return;

    // Remove any commas before formatting
    String plainNumber = value.replaceAll(',', '');

    // Format the number using Indian Numbering Style
    String formattedNumber =
        _indianFormat.format(int.tryParse(plainNumber) ?? 0);

    // Prevent cursor from jumping
    if (formattedNumber != value) {
      amountController.value = amountController.value.copyWith(
        text: formattedNumber,
        selection: TextSelection.collapsed(offset: formattedNumber.length),
      );
    }
  }
}
