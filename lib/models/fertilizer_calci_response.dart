// npk_status.dart
class NPKStatus {
  final String n;
  final int nitrogenValue;
  final String p;
  final int phosphorousValue;
  final String k;
  final int potassiumValue;

  NPKStatus({
    required this.n,
    required this.nitrogenValue,
    required this.p,
    required this.phosphorousValue,
    required this.k,
    required this.potassiumValue,
  });

  factory NPKStatus.fromJson(Map<String, dynamic> json) {
    return NPKStatus(
      n: json['N'],
      nitrogenValue: json['Nitrogen_Value'],
      p: json['P'],
      phosphorousValue: json['Phosphorous_Value'],
      k: json['K'],
      potassiumValue: json['Potassium_Value'],
    );
  }
}

// results.dart
class Fertilizer {
  final double kgPerHa;
  final int bags50Kg;
  final double priceRs;

  Fertilizer({
    required this.kgPerHa,
    required this.bags50Kg,
    required this.priceRs,
  });

  factory Fertilizer.fromJson(Map<String, dynamic> json) {
    return Fertilizer(
      kgPerHa: json['Kg/ha'].toDouble(),
      bags50Kg: json['(50 kg bag)'],
      priceRs: json['Price (Rs)'].toDouble(),
    );
  }
}

class Results {
  final Fertilizer urea;
  final Fertilizer superPhosphate;
  final Fertilizer potash;

  Results({
    required this.urea,
    required this.superPhosphate,
    required this.potash,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      urea: Fertilizer.fromJson(json['Urea']),
      superPhosphate: Fertilizer.fromJson(json['Super Phosphate']),
      potash: Fertilizer.fromJson(json['Potash']),
    );
  }
}

// api_response.dart
class FertilizerResponse {
  final List<NPKStatus> npkStatus;
  final List<Results> results;

  FertilizerResponse({
    required this.npkStatus,
    required this.results,
  });

  factory FertilizerResponse.fromJson(Map<String, dynamic> json) {
    return FertilizerResponse(
      npkStatus: (json['NPK Status'] as List)
          .map((item) => NPKStatus.fromJson(item))
          .toList(),
      results: (json['results'] as List)
          .map((item) => Results.fromJson(item))
          .toList(),
    );
  }
}
