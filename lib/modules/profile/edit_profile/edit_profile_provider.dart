import 'dart:developer';
import 'dart:io';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:amtech_design/models/get_personal_details_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../models/get_business_details_model.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../../services/network/api_service.dart';
import '../../menu/menu_provider.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessOwnerController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();

  TextEditingController personalFirstNameController = TextEditingController();
  TextEditingController personalLastNameController = TextEditingController();

  final ApiService apiService = ApiService();
  bool isDetailsLoading = false;

  GetBusinessDetailsModel? detailsResponse;
  GetPersonalDetailsModel? personalDetailsResponse;
  String? selectedBusinessType;

  List<String> businessTypeItems = [
    'Sole Proprietorship',
    'Partnership',
    'Limited Liability Partnership (LLP)',
    'Limited Liability Company (LLC)',
    'Private Limited Company',
  ];

  onChangeBusinessType(String? newValue) {
    selectedBusinessType = newValue;
    notifyListeners();
  }

  String? businessProfileImage;
  String? personalProfileImage;

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
        selectedBusinessImage = null; // Clear preview after upload
        detailsResponse = res;
        final data = detailsResponse?.data;
        businessNameController.text = data?.businessName ?? '';
        businessOwnerController.text = data?.ownerName ?? '';
        addressController.text = data?.address ?? '';
        mobileController.text = data?.contact?.toString() ?? '';
        businessEmailController.text = data?.email ?? '';
        //* Assign businessType
        selectedBusinessType =
            businessTypeItems.contains(data?.buninessType?.trim())
                ? data!.buninessType!.trim()
                : null; // or `null` or any valid default
        businessProfileImage = data?.profileImage;
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
  Future<void> getPersonalDetails() async {
    isDetailsLoading = true;
    notifyListeners();
    try {
      final res = await apiService.getPersonalDetails(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
      );
      log('personalDetailsResponse: ${res.data}');
      if (res.success == true) {
        selectedPersonalImage = null; // Clear preview after upload
        personalDetailsResponse = res;
        final personal = personalDetailsResponse?.data;
        personalFirstNameController.text = personal?.firstName ?? 'null';
        personalLastNameController.text = personal?.lastName ?? 'null';
        addressController.text = personal?.address ?? 'null';
        mobileController.text = personal?.contact?.toString() ?? 'null';
        personalProfileImage = personal?.profileImage;
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

  //* Picked business profile image
  File? pickedBusinessImage;
  File? pickedPersonalImage;

  File? selectedBusinessImage;
  File? selectedPersonalImage;

  //* Pick Business image
  Future<void> pickBusinessImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedBusinessImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  //* Pick Personal image
  Future<void> pickPersonalImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedPersonalImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  ImageProvider getBusinessProfileImage() {
    if (selectedBusinessImage != null) {
      // Show picked image as preview before uploading
      return FileImage(selectedBusinessImage!);
    } else if (businessProfileImage?.isNotEmpty == true) {
      // Show image from server after upload
      return CachedNetworkImageProvider(businessProfileImage!);
    } else {
      // Fallback
      return const AssetImage(ImageStrings.defaultAvatar);
    }
  }

  ImageProvider getPersonalProfileImage() {
    if (selectedPersonalImage != null) {
      // Show picked image as preview before uploading
      return FileImage(selectedPersonalImage!);
    } else if (personalProfileImage?.isNotEmpty == true) {
      // Show image from server after upload
      return CachedNetworkImageProvider(personalProfileImage!);
    } else {
      // Fallback
      return const AssetImage(ImageStrings.defaultAvatar);
    }
  }

  bool isEditProfileLoading = false;

  //* EditProfile API
  Future<void> editBusinessProfile(
    BuildContext context,
  ) async {
    isEditProfileLoading = true;
    notifyListeners();
    try {
      final res = await apiService.editProfile(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
        ownerName: businessOwnerController.text.trim(),
        address: addressController.text.trim(),
        buninessType: selectedBusinessType ?? '',
        businessName: businessNameController.text.trim(),
        contact: mobileController.text.trim(),
        email: businessEmailController.text.trim(),
        profileImage: selectedBusinessImage,
      );
      if (res.success == true) {
        selectedBusinessImage = null; // Clear preview after upload
        context.read<MenuProvider>().homeMenuApi(); //* API call
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
      final res = await apiService.editPersonalProfile(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
        firstName: personalFirstNameController.text.trim(),
        lastName: personalLastNameController.text.trim(),
        contact: mobileController.text.trim(),
        address: addressController.text.trim(),
        profileImage: selectedPersonalImage,
      );
      if (res.success == true) {
        selectedPersonalImage = null; // Clear preview after upload
        context.read<MenuProvider>().homeMenuApi(); //* API call
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
