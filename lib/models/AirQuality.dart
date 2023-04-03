class AirQuality {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;

  AirQuality(
      {this.latitude,
      this.longitude,
      this.generationtimeMs,
      this.utcOffsetSeconds,
      this.timezone,
      this.timezoneAbbreviation,
      this.hourlyUnits,
      this.hourly});

  AirQuality.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
    generationtimeMs = json["generationtime_ms"];
    utcOffsetSeconds = json["utc_offset_seconds"];
    timezone = json["timezone"];
    timezoneAbbreviation = json["timezone_abbreviation"];
    hourlyUnits = json["hourly_units"] == null
        ? null
        : HourlyUnits.fromJson(json["hourly_units"]);
    hourly = json["hourly"] == null ? null : Hourly.fromJson(json["hourly"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["generationtime_ms"] = generationtimeMs;
    _data["utc_offset_seconds"] = utcOffsetSeconds;
    _data["timezone"] = timezone;
    _data["timezone_abbreviation"] = timezoneAbbreviation;
    if (hourlyUnits != null) {
      _data["hourly_units"] = hourlyUnits?.toJson();
    }
    if (hourly != null) {
      _data["hourly"] = hourly?.toJson();
    }
    return _data;
  }
}

class Hourly {
  List<String>? time;
  List<double>? pm10;
  List<double>? pm25;
  List<double>? carbonMonoxide;
  List<double>? nitrogenDioxide;
  List<double>? sulphurDioxide;
  List<double>? ozone;
  List<double>? dust;
  List<double>? uvIndex;
  List<dynamic>? ammonia;

  Hourly(
      {this.time,
      this.pm10,
      this.pm25,
      this.carbonMonoxide,
      this.nitrogenDioxide,
      this.sulphurDioxide,
      this.ozone,
      this.dust,
      this.uvIndex,
      this.ammonia});

  Hourly.fromJson(Map<String, dynamic> json) {
    time = json["time"] == null ? null : List<String>.from(json["time"]);
    pm10 = json["pm10"] == null ? null : List<double>.from(json["pm10"]);
    pm25 = json["pm2_5"] == null ? null : List<double>.from(json["pm2_5"]);
    carbonMonoxide = json["carbon_monoxide"] == null
        ? null
        : List<double>.from(json["carbon_monoxide"]);
    nitrogenDioxide = json["nitrogen_dioxide"] == null
        ? null
        : List<double>.from(json["nitrogen_dioxide"]);
    sulphurDioxide = json["sulphur_dioxide"] == null
        ? null
        : List<double>.from(json["sulphur_dioxide"]);
    ozone = json["ozone"] == null ? null : List<double>.from(json["ozone"]);
    dust = json["dust"] == null ? null : List<double>.from(json["dust"]);
    uvIndex =
        json["uv_index"] == null ? null : List<double>.from(json["uv_index"]);
    ammonia =
        json["ammonia"] == null ? null : List<dynamic>.from(json["ammonia"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (time != null) {
      _data["time"] = time;
    }
    if (pm10 != null) {
      _data["pm10"] = pm10;
    }
    if (pm25 != null) {
      _data["pm2_5"] = pm25;
    }
    if (carbonMonoxide != null) {
      _data["carbon_monoxide"] = carbonMonoxide;
    }
    if (nitrogenDioxide != null) {
      _data["nitrogen_dioxide"] = nitrogenDioxide;
    }
    if (sulphurDioxide != null) {
      _data["sulphur_dioxide"] = sulphurDioxide;
    }
    if (ozone != null) {
      _data["ozone"] = ozone;
    }
    if (dust != null) {
      _data["dust"] = dust;
    }
    if (uvIndex != null) {
      _data["uv_index"] = uvIndex;
    }
    if (ammonia != null) {
      _data["ammonia"] = ammonia;
    }
    return _data;
  }
}

class HourlyUnits {
  String? time;
  String? pm10;
  String? pm25;
  String? carbonMonoxide;
  String? nitrogenDioxide;
  String? sulphurDioxide;
  String? ozone;
  String? dust;
  String? uvIndex;
  String? ammonia;

  HourlyUnits(
      {this.time,
      this.pm10,
      this.pm25,
      this.carbonMonoxide,
      this.nitrogenDioxide,
      this.sulphurDioxide,
      this.ozone,
      this.dust,
      this.uvIndex,
      this.ammonia});

  HourlyUnits.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    pm10 = json["pm10"];
    pm25 = json["pm2_5"];
    carbonMonoxide = json["carbon_monoxide"];
    nitrogenDioxide = json["nitrogen_dioxide"];
    sulphurDioxide = json["sulphur_dioxide"];
    ozone = json["ozone"];
    dust = json["dust"];
    uvIndex = json["uv_index"];
    ammonia = json["ammonia"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["pm10"] = pm10;
    _data["pm2_5"] = pm25;
    _data["carbon_monoxide"] = carbonMonoxide;
    _data["nitrogen_dioxide"] = nitrogenDioxide;
    _data["sulphur_dioxide"] = sulphurDioxide;
    _data["ozone"] = ozone;
    _data["dust"] = dust;
    _data["uv_index"] = uvIndex;
    _data["ammonia"] = ammonia;
    return _data;
  }
}
