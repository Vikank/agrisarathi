class ApiEndPoints {
  static final String baseUrl = 'https://api.agrisarathi.com/api/';
  static final String imageBaseUrl = 'https://64.227.166.238/api/media/';
  static final String getCommunityPost = 'Get_Community_Posts_List';
  static const dukanAll = 'Dukan_all';
  static const getOnlyShop = 'Get_CategoryShops';
  static const getSingleShop = 'get_single_shop';
  static const getSingleProduct = 'GetSingleProductinfo';
  static const detectDisease = 'Detect_Disease';
  static const getServiceProviderList = 'Service_Provider_List';
  static const getUserCrops = 'Get_Users_Crops';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();

}

class _AuthEndPoints {
  final String registerEmail = 'Fpo_Signup';
  final String loginEmail = 'Fpo_Login';
  final String getAllStatesUrl = 'GetallStates';
  final String getStateWiseDistrictUrl = 'GetStateWiseDistrict';
  final String forgotPasswordGetOtp = 'forgot_sendotp';
  final String verifyOtp = 'verify_otp';
  final String farmerLogin = 'Farmer_Login';
  final String changePassword = 'reset_password';
  final String createFarmerAddress = 'AddFarmlandByFarmer';
  final String getFarmerFpoName = 'FarmerFpoPart';
  final String updateFpoDetails = 'FPO_profile_update';
  final String updateFarmerDetails = 'FarmerUpdte_Profile';
  final String getAllNews = 'GetCurrentNews';
  final String getFarmerLands = 'GetFarmbyFarmer';
  final String getFarmerDetails = 'GetFarmProfileDetails';
  final String getDiseaseHistory = 'GetDiagnosisReport';
  final String getSingleDiseaseHistory = 'GetSingleDiagnosisReport';
  final String getCropSuggestion = 'Get_Suggested_Crops';
}