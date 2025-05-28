class RazorPayKeys {
  static const String testKey = "rzp_test_BMJsOprMezADK7"; // * Test key
  static const String liveKey = 'rzp_live_Tfjwk5e3xTb5vA'; // * Live key Amtech
}

class SharedPrefsKeys {
  static const String userToken = 'user_token';
  static const String fcmToken = 'fcm_token';
  static const String deviceId = 'device_id';
  static const String userId = 'user_id';
  static const String userContact = 'user_contact';
  static const String isLoggedIn = 'is_logged_in';
  static const String accountType = 'accoun_type';
  static const String location = 'location';
  static const String company = 'company';
  static const String firstSecondaryAccessList = 'firstSecondaryAccessList';
  static const String secondaryAccessList = 'secondaryAccessList';
  static const String currentLat = 'lat';
  static const String currentLong = 'long';
  static const String selectedAddress = 'selectedAddress';
  static const String selectedAddressType = 'selectedAddressType';
  static const String userName = 'user_name';
  static const String remainingPerksAmount = 'remaining_perks_amount';
  static const String confirmDistance = 'confirm_distance';
}

class SocketEvents {
  static const String orderCreate = 'order-create';
  static const String orderReceive = 'order-receive';
  static const String getOrderStatusEmit = 'get-order-status';
  static const String orderStatusResponseListen = 'order-status-response';
  static const String getAllOrderStatusesEmit = 'get-all-order-statuses';
  static const String allOrderStatusesResponseListen =
      'all-order-statuses-response';
  static const String userLocation = 'user-location';
  static const String realTimeLocationUpdate = 'real-time-location-update';
  static const String userConnected = 'user-connected';
  static const String saveAddressEventName = 'save-address';
  static const String searchSavedLocationListen = 'search-saved-location';
  static const String nearByLocationEvent = 'near-by-location';
  static const String nearByLocationListen = 'nearBy-location';
  static const String searchLocationEvent = 'search-location';
  static const String searchLocationByGoogleListen =
      'search-location-by-google';
}
