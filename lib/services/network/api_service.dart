import 'package:amtech_design/models/api_global_model.dart';
import 'package:amtech_design/models/business_list_model.dart';
import 'package:amtech_design/models/personal_register_model.dart';
import 'package:amtech_design/models/user_login_model.dart';
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
}
