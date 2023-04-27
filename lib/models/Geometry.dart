// class Geometry {
//   double? lat;
//   double? lng;

//   Geometry({this.lat, this.lng});

//   Geometry.fromJson(Map<String, dynamic> json) {
//     lat = json["lat"];
//     lng = json["lng"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["lat"] = lat;
//     _data["lng"] = lng;
//     return _data;
//   }
// }

class Geo {
  var lat;
  var lon;

  Geo(this.lat, this.lon);
}
