import 'package:amtech_design/models/api_global_model.dart';
import 'package:amtech_design/models/get_list_access_model.dart';
import 'package:amtech_design/models/gst_verify_model.dart';
import 'package:amtech_design/models/verify_recharge_model.dart';
import 'package:amtech_design/services/network/api/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/add_to_cart_model.dart';
import '../../models/add_to_cart_request_model.dart';
import '../../models/business_list_model.dart';
import '../../models/deduct_recharge_amount_model.dart';
import '../../models/home_menu_model.dart';
import '../../models/list_cart_model.dart';
import '../../models/menu_details_model.dart';
import '../../models/menu_size_model.dart';
import '../../models/personal_register_model.dart';
import '../../models/update_cart_request_model.dart';
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

  @GET("${ApiEndpoints.gstVerify}/{gstNumber}")
  Future<GstVerifyModel> gstVerify(@Path("gstNumber") String gstNumber);

  @POST(ApiEndpoints.logout)
  Future<ApiGlobalModel> logout(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.createAccess)
  Future<ApiGlobalModel> createAccess(
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiEndpoints.getListAccess)
  Future<GetListAccessModel> getListAccess();

  @DELETE("${ApiEndpoints.deleteAccess}/{userId}")
  Future<ApiGlobalModel> deleteAccess(
    @Path("userId") String userId,
  );

  @GET(ApiEndpoints.home)
  Future<HomeMenuModel> getHomeMenu(
    @Query("userId") String userId,
    @Query("search") String? search,
    @Query("userType") int userType,
  );

  @GET("${ApiEndpoints.menuDetails}/{menuId}")
  Future<MenuDetailsModel> getMenuDetails(
    @Path("menuId") String menuId,
  );

  @GET("${ApiEndpoints.menuSize}/{menuId}")
  Future<MenuSizeModel> getMenuSize(
    @Path("menuId") String menuId,
  );

  @POST(ApiEndpoints.addToCart)
  Future<AddToCartModel> addToCart(
    @Body() AddToCartRequestModel addToCartRequestBody,
  );

  @PATCH(ApiEndpoints.updateCart)
  Future<AddToCartModel> updateCart(
    @Body() UpdateCartRequestModel updateCartRequestBody,
  );

  @GET(ApiEndpoints.listCart)
  Future<ListCartModel> getListCart(
    @Query("userId") String userId,
    @Query("userType") int userType,
  );

  @POST(ApiEndpoints.rechargeDeduct)
  Future<DeductRechargeAmountModel> rechargeDeduct(
    @Body() Map<String, dynamic> body,
  );
}
