class RazorPayKeys {
  // static const String testKey = "rzp_test_gvsZVEPcujnlQ5"; // * Test key
  static const String testKey = "rzp_test_c8K63lGAcqMeS7"; // * Test key
  // static const String liveKey = 'rzp_live_YbWaocbWfEYdCO'; // * Live key Amtech
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
  static const String lat = 'lat';
  static const String long = 'long';
}

class SocketEvents {
  static const String orderCreate = 'order-create';
  static const String orderReceived = 'order-received';
  static const String getOrderStatus = 'get-order-status';
  static const String orderStatusResponse = 'order-status-response';
  static const String userLocation = 'user-location';
  static const String realTimeLocationUpdate = 'real-time-location-update';
  static const String userConnected = 'user-connected';
  static const String saveAddressEventName = 'save-address';
  static const String searchSavedLocationListen = 'search-saved-location';
  static const String nearByLocationEvent = 'near-by-location';
  static const String nearByLocationListen = 'nearBy-location';
}
