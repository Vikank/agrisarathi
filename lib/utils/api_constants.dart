class ApiEndPoints {
  static final String baseUrl = 'http://64.227.166.238:8090/';
  static final String imageBaseUrl = 'http://64.227.166.238:8090/media/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'Fpo_Signup';
  final String loginEmail = 'Fpo_Login';
  final String forgotPasswordGetOtp = 'forgot_sendotp';
  final String verifyOtp = 'verify_otp';
  final String changePassword = 'reset_password';
  final String updateFpoDetails = 'FPO_profile_update';
}