import 'package:amtech_design/models/api_error_model.dart';
import 'package:amtech_design/services/network/api/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/personal_register_model.dart';
import 'api/api_constants.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: BaseUrl.apiBaseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(ApiEndpoints.userRegister)
  Future<PersonalRegisterModel> personalRegister(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.businessRegister)
  @MultiPart()
  Future<ApiGlobalModel> businessRegister(
    @Body() Map<String, dynamic> body,
    @Part() List<MultipartFile> images,
  );
}
