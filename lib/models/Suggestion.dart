class Suggestion {
  String? oldName;
  String? country;
  String? city;
  String? lon;
  String? lat;
  String? formatted;
  Timezone? timezone;
  String? placeId;

  Suggestion(
      {this.oldName,
      this.country,
      this.city,
      this.lon,
      this.lat,
      this.formatted,
      this.timezone,
      this.placeId});

  Suggestion.fromJson(Map<String, dynamic> json) {
    oldName = json["old_name"];
    country = json["country"];
    city = json["city"];
    lon = json["lon"];
    lat = json["lat"];
    formatted = json["formatted"];
    timezone =
        json["timezone"] == null ? null : Timezone.fromJson(json["timezone"]);
    placeId = json["place_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["old_name"] = oldName;
    _data["country"] = country;
    _data["city"] = city;
    _data["lon"] = lon;
    _data["lat"] = lat;
    _data["formatted"] = formatted;
    if (timezone != null) {
      _data["timezone"] = timezone?.toJson();
    }
    _data["place_id"] = placeId;
    return _data;
  }

  // @override
  // String toString() {
  //   return 'Suggestion(description: $formatted, placeId: $placeId, lat: $lat, lng: $lon)';
  // }
}

class Timezone {
  String? name;
  String? offsetStd;

  Timezone({this.name, this.offsetStd});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    offsetStd = json["offset_STD"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["offset_STD"] = offsetStd;
    return _data;
  }
}
