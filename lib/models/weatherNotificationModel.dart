class PopNotificationResponse {
  final List<LandNotification> results;

  PopNotificationResponse({required this.results});

  factory PopNotificationResponse.fromJson(Map<String, dynamic> json) {
    return PopNotificationResponse(
      results: List<LandNotification>.from(json['results'].map((x) => LandNotification.fromJson(x))),
    );
  }
}

class LandNotification {
  final int landId;
  final List<Notifications> notifications;

  LandNotification({required this.landId, required this.notifications});

  factory LandNotification.fromJson(Map<String, dynamic> json) {
    var notificationsJson = json['notifications'] ?? json['notifications'] ?? [];
    return LandNotification(
      landId: json['land_id'],
      notifications: List<Notifications>.from(notificationsJson.map((x) => Notifications.fromJson(x))),
    );
  }
}

class Notifications {
  final int weatherId;
  final int cropId;
  final String stages;
  final String gif;
  final int preferenceNumber;
  final String notificationText;

  Notifications({
    required this.weatherId,
    required this.cropId,
    required this.stages,
    required this.gif,
    required this.preferenceNumber,
    required this.notificationText,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      weatherId: json['weather_id'],
      cropId: json['crop_id'],
      stages: json['stages'],
      gif: json['gif'],
      preferenceNumber: json['preference_number'],
      notificationText: json['notification_text'],
    );
  }
}
