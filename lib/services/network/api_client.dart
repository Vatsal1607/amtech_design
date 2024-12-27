import 'package:amtech_design/models/api_global_model.dart';
import 'package:amtech_design/models/gst_verify_model.dart';
import 'package:amtech_design/models/verify_recharge_model.dart';
import 'package:amtech_design/services/network/api/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/business_list_model.dart';
import '../../models/personal_register_model.dart';
import '../../models/user_login_model.dart';
import '../../models/user_recharge_model.dart';
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
  // @MultiPart()
  Future<ApiGlobalModel> businessRegister(
    @Body() Map<String, dynamic> body,
    // @Part(name: 'images') List<MultipartFile> images,
  );

  @GET(ApiEndpoints.businessList)
  Future<BusinessListModel> getBusinessList(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('search') String search,
  );

  //* for both personal & business
  @POST(ApiEndpoints.userLogin)
  Future<UserLoginModel> userLogin(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.sendOtp)
  Future<ApiGlobalModel> sendOtp(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.verifyOtp)
  Future<ApiGlobalModel> verifyOtp(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.userRecharge)
  Future<UserRechargeModel> userRecharge(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.verifyRecharge)
  Future<VerifyRechargeModel> verifyRecharge(
    @Body() Map<String, dynamic> body,
  );

  @GET(
      "http://sheet.gstincheck.co.in/check/fd1cc5bfb2f97a038994093a67489392/{gstNumber}")
  Future<GstVerifyModel> gstVerify(@Path("gstNumber") String gstNumber);
}
