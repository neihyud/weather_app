// class Weather {
//   var cityName;
//   var icon;
//   var condition;
//   var temp;
//   var wind;
//   var humidity;
//   var wind_dir;
//   var gust;
//   var uv;
//   var pressure;
//   var pricipe;
//   var last_update;

//   Weather({
//     required this.cityName,
//     required this.condition,
//     required this.gust,
//     required this.humidity,
//     required this.icon,
//     required this.last_update,
//     required this.pressure,
//     required this.pricipe,
//     required this.temp,
//     required this.uv,
//     required this.wind_dir,
//     required this.wind
//   });
// }

class Weather {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentWeather? currentWeather;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;
  DailyUnits? dailyUnits;
  Daily? daily;

  Weather(
      {this.latitude,
      this.longitude,
      this.generationtimeMs,
      this.utcOffsetSeconds,
      this.timezone,
      this.timezoneAbbreviation,
      this.elevation,
      this.currentWeather,
      this.hourlyUnits,
      this.hourly,
      this.dailyUnits,
      this.daily});

  Weather.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
    generationtimeMs = json["generationtime_ms"];
    utcOffsetSeconds = json["utc_offset_seconds"];
    timezone = json["timezone"];
    timezoneAbbreviation = json["timezone_abbreviation"];
    elevation = json["elevation"];
    currentWeather = json["current_weather"] == null
        ? null
        : CurrentWeather.fromJson(json["current_weather"]);
    hourlyUnits = json["hourly_units"] == null
        ? null
        : HourlyUnits.fromJson(json["hourly_units"]);
    hourly = json["hourly"] == null ? null : Hourly.fromJson(json["hourly"]);
    dailyUnits = json["daily_units"] == null
        ? null
        : DailyUnits.fromJson(json["daily_units"]);
    daily = json["daily"] == null ? null : Daily.fromJson(json["daily"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["generationtime_ms"] = generationtimeMs;
    _data["utc_offset_seconds"] = utcOffsetSeconds;
    _data["timezone"] = timezone;
    _data["timezone_abbreviation"] = timezoneAbbreviation;
    _data["elevation"] = elevation;
    if (currentWeather != null) {
      _data["current_weather"] = currentWeather?.toJson();
    }
    if (hourlyUnits != null) {
      _data["hourly_units"] = hourlyUnits?.toJson();
    }
    if (hourly != null) {
      _data["hourly"] = hourly?.toJson();
    }
    if (dailyUnits != null) {
      _data["daily_units"] = dailyUnits?.toJson();
    }
    if (daily != null) {
      _data["daily"] = daily?.toJson();
    }
    return _data;
  }
}

class Daily {
  List<String>? time;
  List<int>? weathercode;
  List<double>? temperature2MMax;
  List<double>? temperature2MMin;
  List<double>? precipitationSum;
  List<double>? precipitationHours;
  List<double>? windspeed10MMax;

  Daily(
      {this.time,
      this.weathercode,
      this.temperature2MMax,
      this.temperature2MMin,
      this.precipitationSum,
      this.precipitationHours,
      this.windspeed10MMax});

  Daily.fromJson(Map<String, dynamic> json) {
    time = json["time"] == null ? null : List<String>.from(json["time"]);
    weathercode = json["weathercode"] == null
        ? null
        : List<int>.from(json["weathercode"]);
    temperature2MMax = json["temperature_2m_max"] == null
        ? null
        : List<double>.from(json["temperature_2m_max"]);
    temperature2MMin = json["temperature_2m_min"] == null
        ? null
        : List<double>.from(json["temperature_2m_min"]);
    precipitationSum = json["precipitation_sum"] == null
        ? null
        : List<double>.from(json["precipitation_sum"]);
    precipitationHours = json["precipitation_hours"] == null
        ? null
        : List<double>.from(json["precipitation_hours"]);
    windspeed10MMax = json["windspeed_10m_max"] == null
        ? null
        : List<double>.from(json["windspeed_10m_max"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (time != null) {
      _data["time"] = time;
    }
    if (weathercode != null) {
      _data["weathercode"] = weathercode;
    }
    if (temperature2MMax != null) {
      _data["temperature_2m_max"] = temperature2MMax;
    }
    if (temperature2MMin != null) {
      _data["temperature_2m_min"] = temperature2MMin;
    }
    if (precipitationSum != null) {
      _data["precipitation_sum"] = precipitationSum;
    }
    if (precipitationHours != null) {
      _data["precipitation_hours"] = precipitationHours;
    }
    if (windspeed10MMax != null) {
      _data["windspeed_10m_max"] = windspeed10MMax;
    }
    return _data;
  }
}

class DailyUnits {
  String? time;
  String? weathercode;
  String? temperature2MMax;
  String? temperature2MMin;
  String? precipitationSum;
  String? precipitationHours;
  String? windspeed10MMax;

  DailyUnits(
      {this.time,
      this.weathercode,
      this.temperature2MMax,
      this.temperature2MMin,
      this.precipitationSum,
      this.precipitationHours,
      this.windspeed10MMax});

  DailyUnits.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    weathercode = json["weathercode"];
    temperature2MMax = json["temperature_2m_max"];
    temperature2MMin = json["temperature_2m_min"];
    precipitationSum = json["precipitation_sum"];
    precipitationHours = json["precipitation_hours"];
    windspeed10MMax = json["windspeed_10m_max"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["weathercode"] = weathercode;
    _data["temperature_2m_max"] = temperature2MMax;
    _data["temperature_2m_min"] = temperature2MMin;
    _data["precipitation_sum"] = precipitationSum;
    _data["precipitation_hours"] = precipitationHours;
    _data["windspeed_10m_max"] = windspeed10MMax;
    return _data;
  }
}

class Hourly {
  List<String>? time;
  List<double>? temperature2M;
  List<double>? apparentTemperature;
  List<double>? precipitation;
  List<int>? weathercode;
  List<int>? cloudcover;
  List<double>? temperature80M;
  List<double>? uvIndex;

  Hourly(
      {this.time,
      this.temperature2M,
      this.apparentTemperature,
      this.precipitation,
      this.weathercode,
      this.cloudcover,
      this.temperature80M,
      this.uvIndex});

  Hourly.fromJson(Map<String, dynamic> json) {
    time = json["time"] == null ? null : List<String>.from(json["time"]);
    temperature2M = json["temperature_2m"] == null
        ? null
        : List<double>.from(json["temperature_2m"]);
    apparentTemperature = json["apparent_temperature"] == null
        ? null
        : List<double>.from(json["apparent_temperature"]);
    precipitation = json["precipitation"] == null
        ? null
        : List<double>.from(json["precipitation"]);
    weathercode = json["weathercode"] == null
        ? null
        : List<int>.from(json["weathercode"]);
    cloudcover =
        json["cloudcover"] == null ? null : List<int>.from(json["cloudcover"]);
    temperature80M = json["temperature_80m"] == null
        ? null
        : List<double>.from(json["temperature_80m"]);
    uvIndex =
        json["uv_index"] == null ? null : List<double>.from(json["uv_index"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (time != null) {
      _data["time"] = time;
    }
    if (temperature2M != null) {
      _data["temperature_2m"] = temperature2M;
    }
    if (apparentTemperature != null) {
      _data["apparent_temperature"] = apparentTemperature;
    }
    if (precipitation != null) {
      _data["precipitation"] = precipitation;
    }
    if (weathercode != null) {
      _data["weathercode"] = weathercode;
    }
    if (cloudcover != null) {
      _data["cloudcover"] = cloudcover;
    }
    if (temperature80M != null) {
      _data["temperature_80m"] = temperature80M;
    }
    if (uvIndex != null) {
      _data["uv_index"] = uvIndex;
    }
    return _data;
  }
}

class HourlyUnits {
  String? time;
  String? temperature2M;
  String? apparentTemperature;
  String? precipitation;
  String? weathercode;
  String? cloudcover;
  String? temperature80M;
  String? uvIndex;

  HourlyUnits(
      {this.time,
      this.temperature2M,
      this.apparentTemperature,
      this.precipitation,
      this.weathercode,
      this.cloudcover,
      this.temperature80M,
      this.uvIndex});

  HourlyUnits.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    temperature2M = json["temperature_2m"];
    apparentTemperature = json["apparent_temperature"];
    precipitation = json["precipitation"];
    weathercode = json["weathercode"];
    cloudcover = json["cloudcover"];
    temperature80M = json["temperature_80m"];
    uvIndex = json["uv_index"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["temperature_2m"] = temperature2M;
    _data["apparent_temperature"] = apparentTemperature;
    _data["precipitation"] = precipitation;
    _data["weathercode"] = weathercode;
    _data["cloudcover"] = cloudcover;
    _data["temperature_80m"] = temperature80M;
    _data["uv_index"] = uvIndex;
    return _data;
  }
}

class CurrentWeather {
  double? temperature;
  double? windspeed;
  double? winddirection;
  int? weathercode;
  String? time;

  CurrentWeather(
      {this.temperature,
      this.windspeed,
      this.winddirection,
      this.weathercode,
      this.time});

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    temperature = json["temperature"];
    windspeed = json["windspeed"];
    winddirection = json["winddirection"];
    weathercode = json["weathercode"];
    time = json["time"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["temperature"] = temperature;
    _data["windspeed"] = windspeed;
    _data["winddirection"] = winddirection;
    _data["weathercode"] = weathercode;
    _data["time"] = time;
    return _data;
  }
}
