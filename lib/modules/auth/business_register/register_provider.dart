import 'dart:developer';
import 'package:amtech_design/models/api_global_model.dart';
import 'package:amtech_design/models/gst_verify_model.dart';
import 'package:amtech_design/models/personal_register_model.dart';
import 'package:amtech_design/modules/auth/business_selection/business_selection_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/snackbar.dart';
import '../../../services/network/api_service.dart';

class RegisterProvider extends ChangeNotifier {
  //! Business account controllers
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessOwnerController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessMobileController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();

  //! Personal account controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController personalAddressController = TextEditingController();
  TextEditingController personalMobileController = TextEditingController();
  TextEditingController personalEmailController = TextEditingController();

  final FocusNode personalMobileFocusNode = FocusNode();
  final FocusNode businessMobileFocusNode = FocusNode();

  @override
  void dispose() {
    businessNameController.dispose();
    businessOwnerController.dispose();
    businessAddressController.dispose();
    businessMobileController.dispose();
    // *
    firstNameController.dispose();
    lastNameController.dispose();
    personalAddressController.dispose();
    personalMobileController.dispose();
    personalMobileFocusNode.dispose();
    businessMobileFocusNode.dispose();
    super.dispose();
  }

  String? selectedPropertyStatus;
  List<String> propertyStatusItems = ['Owner', 'Rental'];
  onChangePropertyStatus(String? newValue) {
    selectedPropertyStatus = newValue;
    notifyListeners();
  }

  String? selectedBusinessType;
  // List<String> businessTypeItems = [
  //   'Sole Proprietorship',
  //   '⁠Partnership',
  //   '⁠Limited Liability Partnership (LLP)',
  //   '⁠Limited Liability Company (LLC)',
  //   '⁠Private Limited Company',
  // ];
  onChangeBusinessType(String? newValue) {
    selectedBusinessType = newValue;
    notifyListeners();
  }

  // Business type start
  List<String> businessTypeItems = [
    'Sole Proprietorship',
    'Partnership',
    'Limited Liability Partnership (LLP)',
    'Limited Liability Company (LLC)',
    'Private Limited Company',
  ];

  bool isDropdownOpen = false;

  void setSelectedBusinessType(String? value) {
    selectedBusinessType = value;
    notifyListeners();
  }

  void setDropdownState(bool isOpen) {
    isDropdownOpen = isOpen;
    notifyListeners();
  }

  // Business type end

  String? businessMobileErrorText;
  String? businessAddressErrorText;
  String? personalMobileErrorText;

  onChangeBusinessNumber(value) {
    if (value.length != 10) {
      businessMobileErrorText = 'Please enter exactly 10 digits';
      notifyListeners();
    } else {
      businessMobileErrorText = null;
      notifyListeners();
      businessMobileFocusNode.unfocus();
    }
  }

  onChangePersonalNumber(value) {
    if (value.length != 10) {
      personalMobileErrorText = 'Please enter exactly 10 digits';
      notifyListeners();
    } else {
      personalMobileErrorText = null;
      notifyListeners();
      personalMobileFocusNode.unfocus();
    }
  }

  final personalFormKey = GlobalKey<FormState>(); // Key to identify the form
  final businessFormKey = GlobalKey<FormState>(); // Key to identify the form

  final ApiService apiService = ApiService();

  PersonalRegisterModel? _personalRegisterModel;
  bool _isLoading = false;

  PersonalRegisterModel? get personalRegisterModel => _personalRegisterModel;
  bool get isLoading => _isLoading;

  List<MultipartFile>? multipartImageList;
  List<String> imageFileNames = []; // To store the filenames of selected images

  //* Api method (personal register)
  Future<void> personalRegister(context) async {
    _isLoading = true;
    notifyListeners();
    try {
      _personalRegisterModel = await apiService.personalRegister({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'contact': '91${personalMobileController.text}',
        'address': personalAddressController.text,
      });
      debugPrint('Personal Register log: $_personalRegisterModel');
      if (_personalRegisterModel?.success == true) {
        Navigator.pop(context);
        customSnackBar(
          context: context,
          message: _personalRegisterModel!.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      }
    } catch (e) {
      log("personalRegister Error: $e");
      if (e is DioException) {
        // Extract ApiError from DioError
        final apiError = ApiGlobalModel.fromJson(e.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      } else {
        // Handle other errors
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //* Pick and add image to list
  Future<void> pickAndAddImageToLists() async {
    final ImagePicker picker = ImagePicker();

    try {
      // Pick a single image from the gallery
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // Extract and store the filename in the List<String>
        imageFileNames.add(image.name);

        // Convert the selected image to MultipartFile and add to multipartImageList
        MultipartFile multipartFile = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
        multipartImageList!.add(multipartFile);

        debugPrint("Image added successfully: ${image.name}");
      } else {
        debugPrint("No image selected.");
      }
    } catch (e) {
      debugPrint("Error selecting or adding image: $e");
    }
  }

  //* Business Register API Call
  Future<void> businessRegister(context) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Prepare the body for the API request
      Map<String, dynamic> body = {
        'businessName': businessNameController.text,
        'ownerName': businessOwnerController.text,
        'ocupant': selectedPropertyStatus,
        // 'images': imageFileNames, // Pass the filenames list as List<String>
        'contact': '91${businessMobileController.text}',
        'address': businessAddressController.text,
        'buninessType': selectedBusinessType.toString(),
        'gst': gstNumberController.text,
        'email': businessEmailController.text,
      };
      print('Mobile number is: ---- 91${businessMobileController.text}------');
      debugPrint('Image filenames being sent: $imageFileNames');

      // Call the API
      ApiGlobalModel response = await apiService.businessRegister(
        body: body,
      );

      log('Business Register Response: $response');
      if (response.success == true) {
        clearFields();
        Navigator.pop(context);
        customSnackBar(
          context: context,
          message: response.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      } else {
        debugPrint('Response Message: ${response.message}');
      }
    } catch (e) {
      log("Business Register Error: $e");
      if (e is DioException) {
        final apiError = ApiGlobalModel.fromJson(e.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      } else {
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isValidGst = false;
  bool isLoadingVerifyGst = false;
  //* gstVerify API
  Future<void> gstVerify(context) async {
    isLoadingVerifyGst = true;
    notifyListeners();
    GstVerifyModel? response;
    try {
      response =
          await apiService.gstVerify(gstNumber: gstNumberController.text);

      log('gstVerify Response: $response');
      if (response.flag == true) {
        isValidGst = true;
      }
    } catch (e) {
      log("gstVerify Error: $e");
      if (e is DioException) {
        final apiError = ApiGlobalModel.fromJson(e.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      } else {
        debugPrint('${response?.message.toString()}');
        customSnackBar(
          context: context,
          message: 'Invalid GSTIN Number',
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      }
    } finally {
      isLoadingVerifyGst = false;
      notifyListeners();
    }
  }

  clearFields() {
    businessNameController.clear();
    businessOwnerController.clear();
    selectedPropertyStatus = null;
    gstNumberController.clear();
    imageFileNames = [];
    businessMobileController.clear();
    businessAddressController.clear();
    selectedBusinessType = null;
  }
}
