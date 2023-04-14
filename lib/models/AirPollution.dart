class AirPollution {
    Main? main;
    Components? components;
    int? dt;

    AirPollution({this.main, this.components, this.dt});

    AirPollution.fromJson(Map<String, dynamic> json) {
        main = json["main"] == null ? null : Main.fromJson(json["main"]);
        components = json["components"] == null ? null : Components.fromJson(json["components"]);
        dt = json["dt"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(main != null) {
            _data["main"] = main?.toJson();
        }
        if(components != null) {
            _data["components"] = components?.toJson();
        }
        _data["dt"] = dt;
        return _data;
    }
}

class Components {
    var co;
    var no;
    var no2;
    var o3;
    var so2;
    var pm25;
    var pm10;
    var nh3;

    Components({this.co, this.no, this.no2, this.o3, this.so2, this.pm25, this.pm10, this.nh3});

    Components.fromJson(Map<String, dynamic> json) {
        co = json["co"];
        no = json["no"];
        no2 = json["no2"];
        o3 = json["o3"];
        so2 = json["so2"];
        pm25 = json["pm2_5"];
        pm10 = json["pm10"];
        nh3 = json["nh3"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["co"] = co;
        _data["no"] = no;
        _data["no2"] = no2;
        _data["o3"] = o3;
        _data["so2"] = so2;
        _data["pm2_5"] = pm25;
        _data["pm10"] = pm10;
        _data["nh3"] = nh3;
        return _data;
    }
}

class Main {
    int? aqi;

    Main({this.aqi});

    Main.fromJson(Map<String, dynamic> json) {
        aqi = json["aqi"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["aqi"] = aqi;
        return _data;
    }
}