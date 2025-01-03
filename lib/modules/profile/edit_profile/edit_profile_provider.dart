import 'package:flutter/material.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessOwnerController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessMobileController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
}
