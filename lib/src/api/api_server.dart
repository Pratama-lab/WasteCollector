// ignore_for_file: constant_identifier_names

class API {
  static const String API_URL = 'https://staging2.junkbee.id/';
  static const String login = 'api/login';
  static const String logout = 'api/logout';
  static const String get = 'api/userdata/get';
  static const String update = 'api/userdata/update';
  static const String updateSocialMedia = 'api/userdata/update/socialmedia';
  static const String updateProfileImage = 'api/userdata/update/image';
  static const String updateDeviceToken = 'api/userdata/update/device-token';
  static const String upcomingCollection =
      'api/wastecollector/collection/upcoming';
  static const String collectionReceived =
      'api/wastecollector/collection/recive';
  static const String getHistoryTransaction =
      'api/wastecollector/wallet/transaction';
  static const String getCollectorDetail = 'api/wastecollector/collection/';
  static const String top_up = 'api/payment/va';
  static const String cancel_topup = 'api/payment/cancel';
}
