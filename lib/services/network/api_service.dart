import 'package:amtech_design/models/api_global_model.dart';
import 'package:amtech_design/models/business_list_model.dart';
import 'package:amtech_design/models/gst_verify_model.dart';
import 'package:amtech_design/models/personal_register_model.dart';
import 'package:amtech_design/models/user_login_model.dart';
import 'package:amtech_design/models/user_recharge_model.dart';
import 'package:amtech_design/models/verify_recharge_model.dart';
import 'package:dio/dio.dart';
import '../../models/add_to_cart_model.dart';
import '../../models/add_to_cart_request_model.dart';
import '../../models/get_list_access_model.dart';
import '../../models/home_menu_model.dart';
import '../../models/list_cart_model.dart';
import '../../models/menu_details_model.dart';
import '../../models/menu_size_model.dart';
import '../../models/update_cart_request_model.dart';
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

  Future<ApiGlobalModel> createAccess({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.createAccess(body);
  }

  Future<GetListAccessModel> getListAccess() async {
    return await apiClient.getListAccess();
  }

  Future<ApiGlobalModel> deleteAccess({userId}) async {
    return await apiClient.deleteAccess(userId);
  }

  Future<HomeMenuModel> getHomeMenu(
      {required String userId, String? search, required int userType}) async {
    return await apiClient.getHomeMenu(
      userId,
      search,
      userType,
    );
  }

  Future<MenuDetailsModel> getMenuDetails({menuId}) async {
    return await apiClient.getMenuDetails(menuId);
  }

  Future<MenuSizeModel> getMenuSize({menuId}) async {
    return await apiClient.getMenuSize(menuId);
  }

  Future<AddToCartModel> addToCart({
    required AddToCartRequestModel addToCartRequestBody,
  }) async {
    return await apiClient.addToCart(addToCartRequestBody);
  }

  Future<AddToCartModel> updateCart({
    required UpdateCartRequestModel updateCartRequestBody,
  }) async {
    return await apiClient.updateCart(updateCartRequestBody);
  }

  Future<ListCartModel> getListCart({
    required String userId,
    required int userType,
  }) async {
    return await apiClient.getListCart(
      userId,
      userType,
    );
  }
}
