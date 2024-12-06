import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:amtech_design/models/api_error_model.dart';
import 'package:amtech_design/models/personal_register_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/snackbar.dart';
import '../../../routes.dart';
import '../../../services/network/api_service.dart';

class RegisterProvider extends ChangeNotifier {
  //! Business account controllers
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessOwnerController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessMobileController = TextEditingController();

  //! Personal account controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController personalAddressController = TextEditingController();
  TextEditingController personalMobileController = TextEditingController();

  @override
  void dispose() {
    businessNameController.dispose();
    businessOwnerController.dispose();
    businessAddressController.dispose();
    businessMobileController.dispose();
    //
    firstNameController.dispose();
    lastNameController.dispose();
    personalAddressController.dispose();
    personalMobileController.dispose();
    super.dispose();
  }

  String? selectedPropertyStatus;

  List<String> propertyStatusItems = ['Owner', 'Rental'];

  onChangePropertyStatus(String? newValue) {
    selectedPropertyStatus = newValue;
    notifyListeners();
  }

  String? businessMobileErrorText;
  String? personalMobileErrorText;

  onChangeBusinessNumber(value) {
    if (value.length != 10) {
      businessMobileErrorText = 'Please enter exactly 10 digits';
      notifyListeners();
    } else {
      businessMobileErrorText = null;
      notifyListeners();
    }
  }

  onChangePersonalNumber(value) {
    if (value.length != 10) {
      personalMobileErrorText = 'Please enter exactly 10 digits';
      notifyListeners();
    } else {
      personalMobileErrorText = null;
      notifyListeners();
    }
  }

  final personalFormKey = GlobalKey<FormState>(); // Key to identify the form
  final businessFormKey = GlobalKey<FormState>(); // Key to identify the form

  final ApiService apiService = ApiService();

  PersonalRegisterModel? _personalRegisterModel;
  bool _isLoading = false;

  PersonalRegisterModel? get personalRegisterModel => _personalRegisterModel;
  bool get isLoading => _isLoading;

  List<String> imagesList = [];

  // Api method (personal register)
  Future<void> personalRegister(context) async {
    _isLoading = true;
    notifyListeners();
    try {
      _personalRegisterModel = await apiService.personalRegister({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'contact': personalMobileController.text,
        'address': personalAddressController.text,
      });
      debugPrint('Personal Register log: $_personalRegisterModel');
      if (_personalRegisterModel?.success == true) {
        Navigator.pop(context);
        customSnackBar(
          context: context,
          message: _personalRegisterModel!.message.toString(),
          backgroundColor: AppColors.primaryColor,
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
          backgroundColor: AppColors.primaryColor,
        );
      } else {
        // Handle other errors
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          backgroundColor: AppColors.primaryColor,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Function to pick an image and add it to the list
  Future<void> pickAndAddImage(context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Convert the image to Base64
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      imagesList.add(base64Image);
      customSnackBar(context: context, message: 'Image Uploaded');
      debugPrint("Image added to the list. Total images: ${imagesList.length}");
    } else {
      debugPrint("No image selected.");
    }
  }

  // Get multipart images

  Future<List<MultipartFile>> getMultipartImages(List<XFile> imageFiles) async {
    List<MultipartFile> multipartImages = [];

    for (var file in imageFiles) {
      multipartImages.add(
        await MultipartFile.fromFile(
          file.path,
          filename: file.name,
        ),
      );
    }

    return multipartImages;
  }

  //* Api method (business register)
  // Future<void> businessRegister(context) async {
  //   if (imagesList.isNotEmpty) {
  //     Map<String, dynamic> body = {
  //       'businessName': businessNameController.text,
  //       'ownerName': businessOwnerController.text,
  //       'ocupant': selectedPropertyStatus,
  //       'images': imagesList,
  //       'contact': businessMobileController.text,
  //       'address': businessAddressController.text,
  //     };
  //     debugPrint('imageString is: ${imagesList.toString()}');
  //     debugPrint('body is: $body');

  //     _isLoading = true;
  //     notifyListeners();
  //     try {
  //       ApiGlobalModel response = await apiService.businessRegister(body, images);
  //       log('Business Register log: $response');
  //       if (response.success == true) {
  //         customSnackBar(
  //           context: context,
  //           message: response.message.toString(),
  //           backgroundColor: AppColors.primaryColor,
  //         );
  //       }
  //     } catch (e) {
  //       debugPrint("businessRegister Error: $e");
  //       if (e is DioException) {
  //         // Extract ApiError from DioError
  //         final apiError = ApiGlobalModel.fromJson(e.response?.data ?? {});
  //         customSnackBar(
  //           context: context,
  //           message: apiError.message.toString(),
  //           backgroundColor: AppColors.primaryColor,
  //         );
  //       } else {
  //         // Handle other errors
  //         customSnackBar(
  //           context: context,
  //           message: 'An unexpected error occurred',
  //           backgroundColor: AppColors.primaryColor,
  //         );
  //       }
  //     } finally {
  //       _isLoading = false;
  //       notifyListeners();
  //     }
  //   } else {
  //     debugPrint("No images to upload.");
  //   }
  // }

  Future<void> businessRegister(context) async {
    try {
      Map<String, dynamic> body = {
        'businessName': businessNameController.text,
        'ownerName': businessOwnerController.text,
        'ocupant': selectedPropertyStatus,
        // 'images': imagesList,
        'contact': businessMobileController.text,
        'address': businessAddressController.text,
      };
      // Pick images
      final ImagePicker picker = ImagePicker();
      final List<XFile>? images = await picker.pickMultiImage();

      if (images != null && images.isNotEmpty) {
        // Convert images to MultipartFile
        final multipartImages = await getMultipartImages(images);

        // Upload images
        final response =
            await apiService.businessRegister(body, multipartImages);
        debugPrint('business Register res: ${response.toString()}');
        // Handle response
        if (response.statusCode == 200) {
          debugPrint("Upload successful: ${response.message}");
        } else {
          debugPrint("Upload failed: ${response.message}");
        }
      } else {
        debugPrint("No images selected.");
      }
    } catch (e) {
      debugPrint("Error uploading images: $e");
    }
  }
}
