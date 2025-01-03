import 'package:amtech_design/models/api_global_model.dart';
import 'package:amtech_design/models/business_list_model.dart';
import 'package:amtech_design/models/gst_verify_model.dart';
import 'package:amtech_design/models/personal_register_model.dart';
import 'package:amtech_design/models/user_login_model.dart';
import 'package:amtech_design/models/user_recharge_model.dart';
import 'package:amtech_design/models/verify_recharge_model.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';
import 'interceptor/dio_interceptor.dart';

class ApiService {
  late ApiClient apiClient;

  ApiService() {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());
    apiClient = ApiClient(dio);
  }

  Future<PersonalRegisterModel> personalRegister(
      Map<String, dynamic> body) async {
    return await apiClient.personalRegister(body);
  }

  Future<ApiGlobalModel> businessRegister({
    required Map<String, dynamic> body,
    // required List<MultipartFile> images,
  }) async {
    return await apiClient.businessRegister(
      body,
      // images,
    );
  }

  Future<BusinessListModel> getBusinessList({
    required int page,
    required int limit,
    required String search,
  }) async {
    return await apiClient.getBusinessList(page, limit, search);
  }

  Future<UserLoginModel> userLogin({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.userLogin(
      body,
    );
  }

  Future<ApiGlobalModel> sendOtp({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.sendOtp(body);
  }

  Future<ApiGlobalModel> verifyOtp({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.verifyOtp(body);
  }

  Future<UserRechargeModel> userRecharge({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.userRecharge(body);
  }

  Future<VerifyRechargeModel> verifyRecharge({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.verifyRecharge(body);
  }

  Future<GstVerifyModel> gstVerify({
    required String gstNumber,
  }) async {
    return await apiClient.gstVerify(gstNumber);
  }

  Future<ApiGlobalModel> logout({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.logout(body);
  }
}
