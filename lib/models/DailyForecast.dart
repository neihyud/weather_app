class DailyForeCast {
  int? dt;
  int? sunrise;
  int? sunset;
  Temp? temp;
  FeelsLike? feelsLike;
  int? pressure;
  int? humidity;
  List<Weather>? weather;
  var speed;
  int? deg;
  var gust;
  int? clouds;
  var pop;
  var rain;

  DailyForeCast(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.weather,
      this.speed,
      this.deg,
      this.gust,
      this.clouds,
      this.pop,
      this.rain});

  DailyForeCast.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
    temp = json["temp"] == null ? null : Temp.fromJson(json["temp"]);
    feelsLike = json["feels_like"] == null
        ? null
        : FeelsLike.fromJson(json["feels_like"]);
    pressure = json["pressure"];
    humidity = json["humidity"];
    weather = json["weather"] == null
        ? null
        : (json["weather"] as List).map((e) => Weather.fromJson(e)).toList();
    speed = json["speed"];
    deg = json["deg"];
    gust = json["gust"];
    clouds = json["clouds"];
    pop = json["pop"];
    rain = json["rain"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["dt"] = dt;
    _data["sunrise"] = sunrise;
    _data["sunset"] = sunset;
    if (temp != null) {
      _data["temp"] = temp?.toJson();
    }
    if (feelsLike != null) {
      _data["feels_like"] = feelsLike?.toJson();
    }
    _data["pressure"] = pressure;
    _data["humidity"] = humidity;
    if (weather != null) {
      _data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    _data["speed"] = speed;
    _data["deg"] = deg;
    _data["gust"] = gust;
    _data["clouds"] = clouds;
    _data["pop"] = pop;
    _data["rain"] = rain;
    return _data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    main = json["main"];
    description = json["description"];
    icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["main"] = main;
    _data["description"] = description;
    _data["icon"] = icon;
    return _data;
  }
}

class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json["day"];
    night = json["night"];
    eve = json["eve"];
    morn = json["morn"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["day"] = day;
    _data["night"] = night;
    _data["eve"] = eve;
    _data["morn"] = morn;
    return _data;
  }
}

class Temp {
  var day;
  var min;
  var max;
  var night;
  var eve;
  var morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json["day"];
    min = json["min"];
    max = json["max"];
    night = json["night"];
    eve = json["eve"];
    morn = json["morn"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["day"] = day;
    _data["min"] = min;
    _data["max"] = max;
    _data["night"] = night;
    _data["eve"] = eve;
    _data["morn"] = morn;
    return _data;
  }
}
