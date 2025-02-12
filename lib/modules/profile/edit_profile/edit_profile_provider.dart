import 'dart:developer';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:amtech_design/models/get_personal_details_model.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../models/get_business_details_model.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../../services/network/api_service.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessOwnerController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();

  TextEditingController personalFirstNameController = TextEditingController();
  TextEditingController personalLastNameController = TextEditingController();
  // TextEditingController personalMobileController = TextEditingController();
  // TextEditingController personalAddressController = TextEditingController();

  final ApiService apiService = ApiService();
  bool isDetailsLoading = false;

  // EditProfileProvider() {
  //   getBusinessDetails(); //* API
  //   getPersonalDetails(); //* API
  // }

  GetBusinessDetailsModel? detailsResponse;
  GetPersonalDetailsModel? personalDetailsResponse;
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
        addressController.text = detailsResponse?.data?.address ?? '';
        mobileController.text = detailsResponse?.data?.contact.toString() ?? '';
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

  //* getPersonalDetails API
  // Todo working...
  Future<void> getPersonalDetails() async {
    isDetailsLoading = true;
    notifyListeners();
    try {
      final res = await apiService.getPersonalDetails(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
      );
      log('personalDetailsResponse: ${res.data}');
      if (res.success == true) {
        personalFirstNameController.text =
            personalDetailsResponse?.data?.firstName ?? '';
        personalLastNameController.text =
            personalDetailsResponse?.data?.lastName ?? '';
        mobileController.text =
            personalDetailsResponse?.data?.contact.toString() ?? '';
        addressController.text = personalDetailsResponse?.data?.address ?? '';
        log('personalDetailsResponse: ${personalDetailsResponse?.data?.firstName}');
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error getPersonalDetails: ${e.toString()}");
    } finally {
      isDetailsLoading = false;
      notifyListeners();
    }
  }

  bool isEditProfileLoading = false;
  //* editProfile API
  Future<void> editProfile(
    BuildContext context,
  ) async {
    isEditProfileLoading = true;
    notifyListeners();
    try {
      final body = {
        'ownerName': businessOwnerController.text,
        'contact': mobileController.text,
        'address': addressController.text,
        // 'profileImage': '',
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
        Navigator.pop(context);
        customSnackBar(context: context, message: '${res.message}');
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error editProfile: ${e.toString()}");
    } finally {
      isEditProfileLoading = false;
      notifyListeners();
    }
  }

  //* editPersonalProfile API
  Future<void> editPersonalProfile(
    BuildContext context,
  ) async {
    isEditProfileLoading = true;
    notifyListeners();
    try {
      final body = {
        'firstName':
            businessOwnerController.text, // Todo change personal values
        'lastName': mobileController.text,
        'contact': addressController.text,
        'address': businessNameController.text,
        'profileImage': businessEmailController.text,
      };
      final res = await apiService.editPersonalProfile(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
        body: body,
      );
      log('editProfile res: ${res.data}');
      if (res.success == true) {
        log('editProfile message: ${res.message.toString()}');
        Navigator.pop(context);
        customSnackBar(context: context, message: '${res.message}');
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error editProfile: ${e.toString()}");
    } finally {
      isEditProfileLoading = false;
      notifyListeners();
    }
  }
}
