import 'dart:io';

import 'package:amtech_design/models/api_global_model.dart';
import 'package:amtech_design/models/favorites_model.dart';
import 'package:amtech_design/models/get_list_access_model.dart';
import 'package:amtech_design/models/gst_verify_model.dart';
import 'package:amtech_design/models/notification_history_model.dart';
import 'package:amtech_design/models/store_status_model.dart';
import 'package:amtech_design/models/subs_day_details_model.dart';
import 'package:amtech_design/models/subscription_create_request_model.dart';
import 'package:amtech_design/models/verify_recharge_model.dart';
import 'package:amtech_design/services/network/api/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/account_switch_model.dart';
import '../../models/add_to_cart_model.dart';
import '../../models/add_to_cart_request_model.dart';
import '../../models/billing_model.dart';
import '../../models/business_list_model.dart';
import '../../models/deduct_recharge_amount_model.dart';
import '../../models/edit_location_model.dart';
import '../../models/edit_location_request_model.dart';
import '../../models/edit_profile_model.dart';
import '../../models/favorite_add_model.dart';
import '../../models/get_all_units_model.dart';
import '../../models/get_banner_model.dart';
import '../../models/get_business_details_model.dart';
import '../../models/get_payment_response_model.dart';
import '../../models/get_personal_details_model.dart';
import '../../models/home_menu_model.dart';
import '../../models/ingredients_and_addons_model.dart';
import '../../models/initiate_payment_model.dart';
import '../../models/list_cart_model.dart';
import '../../models/menu_details_model.dart';
import '../../models/menu_size_model.dart';
import '../../models/personal_register_model.dart';
import '../../models/recharge_history_model.dart';
import '../../models/reorder_model.dart';
import '../../models/subs_list_model.dart';
import '../../models/subscription_create_model.dart';
import '../../models/subscription_modify_request_model.dart';
import '../../models/subscription_summary_model.dart';
import '../../models/unread_notification_model.dart';
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
  Future<ApiGlobalModel> businessRegister(
    @Body() Map<String, dynamic> body,
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
    @Body() AddToCartRequestModel updateCartRequestBody,
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

  @POST(ApiEndpoints.favoritesAdd)
  Future<FavoriteAddModel> favoritesAdd(
    @Body() Map<String, dynamic> body,
  );

  @DELETE("${ApiEndpoints.removeFavorite}/{menuId}")
  Future<ApiGlobalModel> removeFavorite(
    @Path("menuId") String menuId,
    @Field("userId") String userId,
  );

  @GET('${ApiEndpoints.getFavorite}/{userId}')
  Future<FavoritesModel> getFavorite(
    @Path("userId") String userId,
  );

  @GET(ApiEndpoints.reorderList)
  Future<ReorderModel> reorderList(
    @Query("page") int page,
    @Query("limit") int limit,
    @Query("userId") String userId,
    @Query("startDate") String? startDate,
    @Query("endDate") String? endDate,
  );

  @DELETE("${ApiEndpoints.clearCart}/{cartId}")
  Future<ApiGlobalModel> clearCart(
    @Path("cartId") String cartId,
  );

  @GET(ApiEndpoints.billingList)
  Future<BillingModel> billingList(
    @Query("page") int? currentPage,
    @Query("limit") int? limit,
    @Query("userId") String userId,
    @Query("startDate") String? startDate,
    @Query("endDate") String? endDate,
  );

  @GET('${ApiEndpoints.businessDetails}/{userId}')
  Future<GetBusinessDetailsModel> getBusinessDetails(
    @Path('userId') String userId,
  );

  //* Edit Business profile
  @PUT('${ApiEndpoints.editProfile}/{userId}')
  @MultiPart()
  Future<EditProfileModel> editProfile(
    @Path('userId') String userId,
    @Part(name: 'ownerName') String ownerName,
    @Part(name: 'contact') String contact,
    @Part(name: 'address') String address,
    @Part(name: 'businessName') String businessName,
    @Part(name: 'email') String email,
    @Part(name: 'buninessType') String buninessType,
    @Part(name: "profileImage") File? profileImage,
  );

  @GET('${ApiEndpoints.getPersonalDetails}/{userId}')
  Future<GetPersonalDetailsModel> getPersonalDetails(
    @Path('userId') String userId,
  );

  //* Edit Personal profile
  @PUT('${ApiEndpoints.editPersonalProfile}/{userId}')
  @MultiPart()
  Future<EditProfileModel> editPersonalProfile(
    @Path('userId') String userId,
    @Part(name: 'firstName') String firstName,
    @Part(name: 'lastName') String lastName,
    @Part(name: 'contact') String contact,
    @Part(name: 'address') String address,
    @Part(name: "profileImage") File? profileImage,
  );

  @POST('${ApiEndpoints.location}/{userId}')
  Future<EditLocationModel> editLocation(
    @Path('userId') String userId,
    @Body() EditLocationRequestModel editLocationRequestModel,
  );

  //* Choose location from Saved Address
  @PUT('${ApiEndpoints.chooseLocation}/{userId}')
  Future<ApiGlobalModel> chooseLocation(
    @Path('userId') String userId,
    @Field() String address, // field () is empty
  );

  // edit-address
  @PUT('${ApiEndpoints.editAddress}/{userId}/{addressId}')
  Future<ApiGlobalModel> editAddress(
    @Path('userId') String userId,
    @Path('addressId') String addressId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("${ApiEndpoints.deleteAddress}/{userId}/{addressId}")
  Future<ApiGlobalModel> deleteAddress(
    @Path("userId") String userId,
    @Path("addressId") String addressId,
  );

  // HDFC initiateJuspayPayment
  @POST(ApiEndpoints.initiateJuspayPayment)
  Future<InitiatePaymentModel> initiateJuspayPayment(
    @Body() Map<String, dynamic> requestBody,
  );

  @GET("${ApiEndpoints.rechargeStatus}/{order_id}")
  Future<GetPaymentResponseModel> getPaymentResponse(
    @Path("order_id") String orderId,
  );

  @POST(ApiEndpoints.rechargeHandleJuspayResponse)
  Future<VerifyRechargeModel> rechargeHandleJuspayResponse(
    @Body() Map<String, dynamic> body,
  );

  // getBanner
  @GET(ApiEndpoints.getBanner)
  Future<GetBennerModel> getBanner();

  // Banner click count
  @PUT('${ApiEndpoints.countBanner}/{bannerId}')
  Future<ApiGlobalModel> countBanner(
    @Path("bannerId") String bannerId,
  );

  @GET("${ApiEndpoints.ingredientsAndAddOns}/{menu_id}")
  Future<IngredientsAndAddOnsModel> getIngredientsAndAddOns(
    @Path("menu_id") String menuId,
  );

  // * Subscription Create
  @POST(ApiEndpoints.subscriptionCreate)
  Future<SubscriptionCreateModel> subscriptionCreate(
    @Body() SubscriptionCreateRequestModel subscriptionCreateRequestModel,
  );

  // * Subscription Summary
  @GET("${ApiEndpoints.subscriptionsDetails}/{subs_id}")
  Future<SubscriptionSummaryModel> subscriptionsDetails(
    @Path("subs_id") String subsId,
  );

  //* Subscription Update
  @PUT('${ApiEndpoints.subscriptionsUpdate}/{subs_id}')
  Future<ApiGlobalModel> subscriptionUpdate(
    @Path("subs_id") String subsId,
    @Body() SubscriptionCreateRequestModel? subscriptionCreateRequestModel,
  );

  //* Subscription Modify (also Update but different requestbody)
  @PUT('${ApiEndpoints.subscriptionsUpdate}/{subs_id}')
  Future<ApiGlobalModel> subscriptionModify(
    @Path("subs_id") String subsId,
    @Body() SubscriptionModifyRequestModel? subscriptionModifyRequestModel,
  );

  @GET(ApiEndpoints.rechargeHistory)
  Future<RechargeHistoryModel> rechargeHistory(
    @Query("userId") String userId,
  );

  @PUT('${ApiEndpoints.subscriptionsPayment}/{subscriptionId}')
  Future<ApiGlobalModel> subscriptionsPayment(
    @Path("subscriptionId") String subscriptionId,
    @Field("razorpayOrderId") String razorpayOrderId,
    @Field("razorpayPaymentId") String razorpayPaymentId,
    @Field("paymentMethod") String paymentMethod,
  );

  // Payment complete normal order deduct
  @PUT('${ApiEndpoints.orderPaymentDeduct}/{order_id}')
  Future<ApiGlobalModel> orderPaymentDeduct(
    @Path("order_id") String orderId,
    @Field("paymentMethod") String paymentMethod,
    //* String for normal order.
    @Field("paymentStatus") String paymentStatus,
  );

  @PUT('${ApiEndpoints.subscriptionsPaymentDeduct}/{subs_id}')
  Future<ApiGlobalModel> subscriptionsPaymentDeduct(
    @Path("subs_id") String subsId,
    @Field("paymentMethod") String paymentMethod,
    //* Bool for Subs order.
    @Field("paymentStatus") bool paymentStatus,
  );

  @PUT('${ApiEndpoints.orderPayment}/{order_id}')
  Future<ApiGlobalModel> orderPayment(
    @Path("order_id") String orderId,
    @Field("razorpayOrderId") String razorpayOrderId,
    @Field("razorpayPaymentId") String razorpayPaymentId,
    @Field("paymentMethod") String paymentMethod,
  );

  @GET(ApiEndpoints.subscriptionsList)
  Future<SubsListModel> getSubsList(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('userId') String userId,
  );

  @GET(ApiEndpoints.notificationHistory)
  Future<NotificationHistoryModel> notificationHistory(
    @Field("userId") String userId,
    @Field("userType") String userType,
  );

  @GET(ApiEndpoints.unreadNotificationCount)
  Future<UnreadNotificationModel> unreadNotificationCount(
    @Field("userId") String userId,
    @Field("userType") String userType,
  );

  @GET('${ApiEndpoints.subsDayDetails}/{subsId}')
  Future<SubsDayDetailsModel> subsDayDetails(
    @Path("subsId") String subsId,
    @Query("day") String day,
  );

  @GET(ApiEndpoints.getAllUnits)
  Future<GetAllUnitsModel> getAllUnits();

  @DELETE("${ApiEndpoints.deleteAccount}/{userId}")
  Future<ApiGlobalModel> deleteAccount(
    @Path("userId") String userId,
  );

  @POST(ApiEndpoints.accountSwitch)
  Future<AccountSwitchModel> accountSwitch(
    @Field('contact') String contact, // with prefix 91
  );

  @POST(ApiEndpoints.feedbackSumbit)
  Future<ApiGlobalModel> feedbackSumbit(
    @Field('userId') String userId,
    @Field('userType') String userType, //BusinessUser or User
    @Field('description') String description,
  );

  // StoreStatusModel
  @GET(ApiEndpoints.storeStatus)
  Future<StoreStatusModel> storeStatus();

  // @POST(ApiEndpoints.subsInvoiceGenrate)
  // Future<SubscriptionCreateModel> subsInvoiceGenrate(
  //   @Field('subscriptionId') String subscriptionId,
  // );
}
