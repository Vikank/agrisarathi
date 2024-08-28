class ApiEndPoints {
  static final String baseUrl = 'https://api.agrisarathi.com/api/';
  static final String baseUrlTest = 'http://64.227.166.238:8090/farmer/';
  static final String imageBaseUrl = 'http://64.227.166.238:8090';
  static final String getCommunityPost = 'Get_Community_Posts_List';
  static const dukanAll = 'Dukan_all';
  static const getOnlyShop = 'Get_CategoryShops';
  static const getSingleShop = 'get_single_shop';
  static const getSingleProduct = 'GetSingleProductinfo';
  static const detectDisease = 'DetectDiseaseAPIView';
  static const getServiceProviderList = 'ServiceProviderList';
  static const getUserCrops = 'Get_Users_Crops';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();

}

class _AuthEndPoints {
  final String registerEmail = 'Fpo_Signup';
  final String loginEmail = 'Fpo_Login';
  final String getAllStatesUrl = 'GetallStates';
  final String getStateWiseDistrictUrl = 'GetStateWiseDistrict';
  final String forgotPasswordGetOtp = 'forgot_sendotp';
  final String verifyOTP = 'VerifyOTP';
  final String farmerLogin = 'FarmerLogin';
  final String changePassword = 'reset_password';
  final String createFarmerAddress = 'FarmerAddGetallLandInfo';
  final String getFarmerFpoName = 'FarmerFpoPart';
  final String updateFpoDetails = 'FPO_profile_update';
  final String updateFarmerDetails = 'FarmerDetailsGetUpdate';
  final String getAllNews = 'GetCurrentNews';
  final String getFarmerLands = 'FarmerAddGetallLandInfo';
  final String getFarmerDetails = 'GetFarmProfileDetails';
  final String getDiseaseHistory = 'GetDiagnosisReport';
  final String getSingleDiseaseHistory = 'GetSingleDiagnosisReport';
  final String getCropSuggestion = 'Get_Suggested_Crops';
  final String getSingleCropSuggestion = 'GetSuggested_Crop_Details';
  final String fertilizersWithTest = 'Fertilizerswithtest';
  final String advanceFertilizerCalculator = 'AdvanceFertilizercalculator';
  final String fertilizersRecommendedDose = 'FertilizersRecommendedDose';
}