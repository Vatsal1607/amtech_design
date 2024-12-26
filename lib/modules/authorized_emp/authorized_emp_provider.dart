import 'package:flutter/material.dart';

class AuthorizedEmpProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
}
