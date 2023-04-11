class HourlyForeCast {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  var visibility;
  var pop;
  Sys? sys;
  String? dtTxt;

  HourlyForeCast(
      {this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.visibility,
      this.pop,
      this.sys,
      this.dtTxt});

  HourlyForeCast.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    main = json["main"] == null ? null : Main.fromJson(json["main"]);
    weather = json["weather"] == null
        ? null
        : (json["weather"] as List).map((e) => Weather.fromJson(e)).toList();
    clouds = json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]);
    wind = json["wind"] == null ? null : Wind.fromJson(json["wind"]);
    visibility = json["visibility"];
    pop = json["pop"];
    sys = json["sys"] == null ? null : Sys.fromJson(json["sys"]);
    dtTxt = json["dt_txt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["dt"] = dt;
    if (main != null) {
      _data["main"] = main?.toJson();
    }
    if (weather != null) {
      _data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    if (clouds != null) {
      _data["clouds"] = clouds?.toJson();
    }
    if (wind != null) {
      _data["wind"] = wind?.toJson();
    }
    _data["visibility"] = visibility;
    _data["pop"] = pop;
    if (sys != null) {
      _data["sys"] = sys?.toJson();
    }
    _data["dt_txt"] = dtTxt;
    return _data;
  }
}

class Sys {
  String? pod;

  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json["pod"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["pod"] = pod;
    return _data;
  }
}

class Wind {
  var speed;
  int? deg;
  var gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json["speed"];
    deg = json["deg"];
    gust = json["gust"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["speed"] = speed;
    _data["deg"] = deg;
    _data["gust"] = gust;
    return _data;
  }
}

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json["all"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["all"] = all;
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

class Main {
  var temp;
  var feelsLike;
  var tempMin;
  var tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  var tempKf;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json["temp"];
    feelsLike = json["feels_like"];
    tempMin = json["temp_min"];
    tempMax = json["temp_max"];
    pressure = json["pressure"];
    seaLevel = json["sea_level"];
    grndLevel = json["grnd_level"];
    humidity = json["humidity"];
    tempKf = json["temp_kf"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["temp"] = temp;
    _data["feels_like"] = feelsLike;
    _data["temp_min"] = tempMin;
    _data["temp_max"] = tempMax;
    _data["pressure"] = pressure;
    _data["sea_level"] = seaLevel;
    _data["grnd_level"] = grndLevel;
    _data["humidity"] = humidity;
    _data["temp_kf"] = tempKf;
    return _data;
  }
}
