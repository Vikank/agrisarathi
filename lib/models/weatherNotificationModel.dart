class WeatherNotificationModel {
  List<Results>? results;

  WeatherNotificationModel({this.results});

  WeatherNotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? cropId;
  List<Notifications>? notifications;

  Results({this.cropId, this.notifications});

  Results.fromJson(Map<String, dynamic> json) {
    cropId = json['crop_id'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crop_id'] = this.cropId;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? weatherId;
  int? cropId;
  String? stages;
  String? gif;
  int? preferenceNumber;
  String? notificationText;

  Notifications(
      {this.weatherId,
        this.cropId,
        this.stages,
        this.gif,
        this.preferenceNumber,
        this.notificationText});

  Notifications.fromJson(Map<String, dynamic> json) {
    weatherId = json['weather_id'];
    cropId = json['crop_id'];
    stages = json['stages'];
    gif = json['gif'];
    preferenceNumber = json['preference_number'];
    notificationText = json['notification_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weather_id'] = this.weatherId;
    data['crop_id'] = this.cropId;
    data['stages'] = this.stages;
    data['gif'] = this.gif;
    data['preference_number'] = this.preferenceNumber;
    data['notification_text'] = this.notificationText;
    return data;
  }
}
