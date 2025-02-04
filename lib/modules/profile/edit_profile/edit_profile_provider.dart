import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../models/get_business_details_model.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../../services/network/api_service.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessOwnerController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessMobileController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();

  final ApiService apiService = ApiService();
  bool isDetailsLoading = false;

  EditProfileProvider() {
    getBusinessDetails(); //* API
  }

  GetBusinessDetailsModel? detailsResponse;
  String? selectedBusinessType;
  List<String> businessTypeItems = [
    'Sole Proprietorship',
    '⁠Partnership',
    '⁠Limited Liability Partnership (LLP)',
    '⁠Limited Liability Company (LLC)',
    '⁠Private Limited Company',
  ];
  onChangeBusinessType(String? newValue) {
    selectedBusinessType = newValue;
    notifyListeners();
  }

  //* getBusinessDetails API
  Future<void> getBusinessDetails() async {
    isDetailsLoading = true;
    notifyListeners();
    try {
      final res = await apiService.getBusinessDetails(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
      );
      log('getBusinessDetails: ${res.data}');
      if (res.success == true) {
        detailsResponse = res;
        businessNameController.text = detailsResponse?.data?.businessName ?? '';
        businessOwnerController.text = detailsResponse?.data?.ownerName ?? '';
        businessAddressController.text = detailsResponse?.data?.address ?? '';
        businessMobileController.text =
            detailsResponse?.data?.contact.toString() ?? '';
        businessEmailController.text = detailsResponse?.data?.email ?? '';
        selectedBusinessType = detailsResponse?.data?.buninessType ?? '';
        // log(getBusinessDetails.data.toString());
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error getBusinessDetails: ${e.toString()}");
    } finally {
      isDetailsLoading = false;
      notifyListeners();
    }
  }

  //* editProfile API
  // Todo need to call this api on done button
  Future<void> editProfile() async {
    // isDetailsLoading = true;
    notifyListeners();
    try {
      final body = {
        'ownerName': businessOwnerController.text,
        'contact': businessMobileController.text,
        'address': businessAddressController.text,
        // 'profileImage': ,
        'businessName': businessNameController.text,
        'email': businessEmailController.text,
        'buninessType': selectedBusinessType,
      };
      final res = await apiService.editProfile(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
        body: body,
      );
      log('editProfile res: ${res.data}');
      if (res.success == true) {
        log('editProfile message: ${res.message.toString()}');
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error editProfile: ${e.toString()}");
    } finally {
      // isDetailsLoading = false;
      notifyListeners();
    }
  }
}
