class AppConstants {
  static const String baseUrl =
      'http://localhost:8088'; // Local
  static const String apiPrefix = '/api/v1';
  static const int connectTimeout = 15000; // milliseconds
  static const int receiveTimeout = 15000; // milliseconds

  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String darkModeKey = 'dark_mode';

  static const String appName = 'Spaced Learning';

  static const Duration quickDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 350);
  static const Duration longDuration = Duration(milliseconds: 500);

  static const int noonReminderHour = 12;
  static const int noonReminderMinute = 30;

  static const int eveningFirstReminderHour = 21;
  static const int eveningFirstReminderMinute = 0;

  static const int eveningSecondReminderHour = 22;
  static const int eveningSecondReminderMinute = 30;

  static const int endOfDayReminderHour = 23;
  static const int endOfDayReminderMinute = 30;

  static const int noonReminderCallbackId = 1001;
  static const int eveningFirstReminderCallbackId = 1002;
  static const int eveningSecondReminderCallbackId = 1003;
  static const int endOfDayReminderCallbackId = 1004;
}
