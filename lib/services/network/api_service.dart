import 'package:amtech_design/models/personal_register_model.dart';
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
}
