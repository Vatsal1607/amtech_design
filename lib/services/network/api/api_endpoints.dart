class ApiEndpoints {
  static const String userRegister = 'register';
  static const String businessRegister = 'create';
  static const String businessList = 'business/list';
  static const String userLogin = 'login';
  static const String sendOtp = 'send-otp';
  static const String verifyOtp = 'verify-otp';
  static const String userRecharge = 'user/recharge';
  static const String verifyRecharge = 'recharge/verifyPayment';
  static const String gstVerify =
      'http://sheet.gstincheck.co.in/check/fd1cc5bfb2f97a038994093a67489392';
  static const String logout = 'logout';
  static const String createAccess = 'business/create-access';
  static const String getListAccess = 'business/access';
  static const String deleteAccess = 'business/delete-access';
  static const String home = 'menu/users-lists';
  static const String menuDetails = 'menu/user-details';
  static const String menuSize = 'menu/size';
  static const String addToCart = 'user/add-cart';
  static const String updateCart = 'user/update-cart';
  static const String listCart = 'user/list-cart';
  static const String rechargeDeduct = 'recharge/deduct';
  static const String favoritesAdd = 'favorites/add';
  static const String removeFavorite = 'favorites';
  static const String getFavorite = 'favorites';
  static const String reorderList = 'order/reorder-list';
  static const String clearCart = 'user/clear-cart';
  static const String billingList = 'order/invoice-list';
  static const String businessDetails = 'business-details';
  static const String editProfile = 'business/update';
  static const String getPersonalDetails = 'user/view';
  static const String editPersonalProfile = 'user/update';
  static const String location = 'location';
  static const String chooseLocation = 'choose-location';
  static const String editAddress = 'edit-address';
  static const String deleteAddress = 'delete-address';
  static const String initiateJuspayPayment = 'user/initiateJuspayPayment';
  static const String rechargeStatus = 'recharge/status';
  static const String rechargeHandleJuspayResponse =
      'recharge/handleJuspayResponse';
  static const String getBanner = 'get/banner';
  static const String countBanner = 'count/banner';
  static const String ingredientsAndAddOns = 'subscription/menu/details';
  static const String subscriptionCreate = 'subscription/create';
  static const String subscriptionsDetails = 'subscriptions/details';
  static const String subscriptionsUpdate = 'subscriptions/update';
  static const String rechargeHistory = 'recharge/history';
  static const String subscriptionsPayment = 'subscription/payment';
  static const String orderPaymentDeduct = 'order/payment/deduct';
  static const String subscriptionsPaymentDeduct =
      'subscriptions/payment/deduct';
  static const String orderPayment = 'order/payment';
  static const String subscriptionsList = 'user/subscriptions/list';
  static const String notificationHistory = 'notifications/users/history';
  static const String unreadNotificationCount = 'unread';
  static const String subsDayDetails = 'subscriptions/day/details';
}
