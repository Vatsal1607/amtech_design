import 'package:amtech_design/models/api_global_model.dart';
import 'package:amtech_design/models/billing_model.dart';
import 'package:amtech_design/models/business_list_model.dart';
import 'package:amtech_design/models/deduct_recharge_amount_model.dart';
import 'package:amtech_design/models/edit_location_model.dart';
import 'package:amtech_design/models/edit_location_request_model.dart';
import 'package:amtech_design/models/edit_profile_model.dart';
import 'package:amtech_design/models/favorite_add_model.dart';
import 'package:amtech_design/models/favorites_model.dart';
import 'package:amtech_design/models/get_business_details_model.dart';
import 'package:amtech_design/models/gst_verify_model.dart';
import 'package:amtech_design/models/ingredients_and_addons_model.dart';
import 'package:amtech_design/models/personal_register_model.dart';
import 'package:amtech_design/models/recharge_history_model.dart';
import 'package:amtech_design/models/reorder_model.dart';
import 'package:amtech_design/models/user_login_model.dart';
import 'package:amtech_design/models/user_recharge_model.dart';
import 'package:amtech_design/models/verify_recharge_model.dart';
import 'package:dio/dio.dart';
import '../../models/add_to_cart_model.dart';
import '../../models/add_to_cart_request_model.dart';
import '../../models/get_banner_model.dart';
import '../../models/get_list_access_model.dart';
import '../../models/get_payment_response_model.dart';
import '../../models/get_personal_details_model.dart';
import '../../models/home_menu_model.dart';
import '../../models/initiate_payment_model.dart';
import '../../models/list_cart_model.dart';
import '../../models/menu_details_model.dart';
import '../../models/menu_size_model.dart';
import '../../models/notification_history_model.dart';
import '../../models/subs_day_details_model.dart';
import '../../models/subs_list_model.dart';
import '../../models/subscription_create_model.dart';
import '../../models/subscription_create_request_model.dart';
import '../../models/subscription_modify_request_model.dart';
import '../../models/subscription_summary_model.dart';
import '../../models/unread_notification_model.dart';
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
    required AddToCartRequestModel updateCartRequestBody,
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

  Future<DeductRechargeAmountModel> rechargeDeduct({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.rechargeDeduct(
      body,
    );
  }

  // favoritesAdd
  Future<FavoriteAddModel> favoritesAdd({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.favoritesAdd(body);
  }

  Future<ApiGlobalModel> removeFavorite({
    required String menuId,
    required String userId,
  }) async {
    return await apiClient.removeFavorite(
      menuId,
      userId,
    );
  }

  Future<FavoritesModel> getFavorite({
    required String userId,
  }) async {
    return await apiClient.getFavorite(
      userId,
    );
  }

  Future<ReorderModel> getReorderList({
    required int page,
    required int limit,
    required String userId,
    String? startDate,
    String? endDate,
  }) async {
    return await apiClient.reorderList(
      page,
      limit,
      userId,
      startDate,
      endDate,
    );
  }

  Future<ApiGlobalModel> clearCart({
    required String cartId,
  }) async {
    return await apiClient.clearCart(cartId);
  }

  Future<BillingModel> getBillingList({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.billingList(body);
  }

  Future<GetBusinessDetailsModel> getBusinessDetails({
    required String userId,
  }) async {
    return await apiClient.getBusinessDetails(userId);
  }

  Future<EditProfileModel> editProfile({
    required String userId,
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.editProfile(userId, body);
  }

  Future<GetPersonalDetailsModel> getPersonalDetails({
    required String userId,
  }) async {
    return await apiClient.getPersonalDetails(userId);
  }

  Future<EditProfileModel> editPersonalProfile({
    required String userId,
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.editPersonalProfile(userId, body);
  }

  Future<EditLocationModel> editLocation({
    required String userId,
    required EditLocationRequestModel editLocationRequestModel,
  }) async {
    return await apiClient.editLocation(userId, editLocationRequestModel);
  }

  Future<ApiGlobalModel> chooseLocation({
    required String userId,
    required String address,
  }) async {
    return await apiClient.chooseLocation(userId, address);
  }

  Future<ApiGlobalModel> editAddress({
    required String userId,
    required String addressId,
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.editAddress(
      userId,
      addressId,
      body,
    );
  }

  Future<ApiGlobalModel> deleteAddress({
    required String userId,
    required String addressId,
  }) async {
    return await apiClient.deleteAddress(
      userId,
      addressId,
    );
  }

  Future<InitiatePaymentModel> initiateJuspayPayment({
    required Map<String, dynamic> requestBody,
  }) async {
    return await apiClient.initiateJuspayPayment(
      requestBody,
    );
  }

  Future<GetPaymentResponseModel> getPaymentResponse({
    required orderId,
  }) async {
    return await apiClient.getPaymentResponse(
      orderId,
    );
  }

  Future<VerifyRechargeModel> rechargeHandleJuspayResponse({
    required Map<String, dynamic> requestBody,
  }) async {
    return await apiClient.rechargeHandleJuspayResponse(
      requestBody,
    );
  }

  Future<GetBennerModel> getBanner() async {
    return await apiClient.getBanner();
  }

  Future<ApiGlobalModel> countBanner({
    required String bannerId,
  }) async {
    return await apiClient.countBanner(
      bannerId,
    );
  }

  Future<IngredientsAndAddOnsModel> getIngredientsAndAddOns({
    required String menuId,
  }) async {
    return await apiClient.getIngredientsAndAddOns(
      menuId,
    );
  }

  Future<SubscriptionCreateModel> subscriptionCreate({
    required SubscriptionCreateRequestModel subscriptionCreateRequestData,
  }) async {
    return await apiClient.subscriptionCreate(
      subscriptionCreateRequestData,
    );
  }

  Future<SubscriptionSummaryModel> subscriptionsSummary({
    required String subsId,
  }) async {
    return await apiClient.subscriptionsDetails(
      subsId,
    );
  }

  Future<ApiGlobalModel> subscriptionUpdate({
    required String subsId,
    SubscriptionCreateRequestModel? subscriptionUpdateRequestData,
  }) async {
    return await apiClient.subscriptionUpdate(
      subsId,
      subscriptionUpdateRequestData,
    );
  }

  Future<ApiGlobalModel> subscriptionModify({
    required String subsId,
    SubscriptionModifyRequestModel? subscriptionModifyRequestModel,
  }) async {
    return await apiClient.subscriptionModify(
      subsId,
      subscriptionModifyRequestModel,
    );
  }

  Future<RechargeHistoryModel> rechargeHistory({required String userId}) async {
    return await apiClient.rechargeHistory(userId);
  }

  Future<ApiGlobalModel> subscriptionsPayment(
      {required String orderId, required String subsId}) async {
    return await apiClient.subscriptionsPayment(orderId, subsId);
  }

  Future<ApiGlobalModel> orderPaymentDeduct({required String orderId}) async {
    return await apiClient.orderPaymentDeduct(orderId);
  }

  Future<ApiGlobalModel> subscriptionsPaymentDeduct(
      {required String subsId}) async {
    return await apiClient.subscriptionsPaymentDeduct(subsId);
  }

  Future<ApiGlobalModel> orderPayment({
    required String orderId,
    required String orderIdByJustpay,
  }) async {
    return await apiClient.orderPayment(orderId, orderIdByJustpay);
  }

  Future<SubsListModel> getSubsList(
      {required int page, required int limit, required String userId}) async {
    return await apiClient.getSubsList(page, limit, userId);
  }

  Future<NotificationHistoryModel> notificationHistory(
      {required String userId, required String userType}) async {
    return await apiClient.notificationHistory(userId, userType);
  }

  Future<UnreadNotificationModel> unreadNotificationCount(
      {required String userId, required String userType}) async {
    return await apiClient.unreadNotificationCount(userId, userType);
  }

  Future<SubsDayDetailsModel> subsDayDetails({
    required String subsId,
    required String day,
  }) async {
    return await apiClient.subsDayDetails(subsId, day);
  }
}
