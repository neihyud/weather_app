class CurrentForeCast {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  int? timezone;
  int? id;
  String? name;
  var cod;

  CurrentForeCast(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  CurrentForeCast.fromJson(Map<String, dynamic> json) {
    coord = json["coord"] == null ? null : Coord.fromJson(json["coord"]);
    weather = json["weather"] == null
        ? null
        : (json["weather"] as List).map((e) => Weather.fromJson(e)).toList();
    base = json["base"];
    main = json["main"] == null ? null : Main.fromJson(json["main"]);
    visibility = json["visibility"];
    wind = json["wind"] == null ? null : Wind.fromJson(json["wind"]);
    clouds = json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]);
    dt = json["dt"];
    timezone = json["timezone"];
    id = json["id"];
    name = json["name"];
    cod = json["cod"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (coord != null) {
      _data["coord"] = coord?.toJson();
    }
    if (weather != null) {
      _data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    _data["base"] = base;
    if (main != null) {
      _data["main"] = main?.toJson();
    }
    _data["visibility"] = visibility;
    if (wind != null) {
      _data["wind"] = wind?.toJson();
    }
    if (clouds != null) {
      _data["clouds"] = clouds?.toJson();
    }
    _data["dt"] = dt;
    _data["timezone"] = timezone;
    _data["id"] = id;
    _data["name"] = name;
    _data["cod"] = cod;
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

class Main {
  var temp;
  var feelsLike;
  var tempMin;
  var tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.grndLevel});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json["temp"];
    feelsLike = json["feels_like"];
    tempMin = json["temp_min"];
    tempMax = json["temp_max"];
    pressure = json["pressure"];
    humidity = json["humidity"];
    seaLevel = json["sea_level"];
    grndLevel = json["grnd_level"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["temp"] = temp;
    _data["feels_like"] = feelsLike;
    _data["temp_min"] = tempMin;
    _data["temp_max"] = tempMax;
    _data["pressure"] = pressure;
    _data["humidity"] = humidity;
    _data["sea_level"] = seaLevel;
    _data["grnd_level"] = grndLevel;
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

class Coord {
  var lon;
  var lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json["lon"];
    lat = json["lat"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["lon"] = lon;
    _data["lat"] = lat;
    return _data;
  }
}
