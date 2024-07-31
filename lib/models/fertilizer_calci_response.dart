class FertilizerResponse {
  final Map<String, String> npkStatus;
  final Map<String, Map<String, dynamic>> results;

  FertilizerResponse({required this.npkStatus, required this.results});

  factory FertilizerResponse.fromJson(Map<String, dynamic> json) {
    return FertilizerResponse(
      npkStatus: Map<String, String>.from(json['NPK Status'][0]),
      results: {
        'Urea': Map<String, dynamic>.from(json['results'][0]['Urea']),
        'Super Phosphate': Map<String, dynamic>.from(json['results'][0]['Super Phosphate']),
        'Potash': Map<String, dynamic>.from(json['results'][0]['Potash']),
      },
    );
  }
}