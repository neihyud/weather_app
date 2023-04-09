class LocationDetail {
    Result? result;
    String? status;

    LocationDetail({this.result, this.status});

    LocationDetail.fromJson(Map<String, dynamic> json) {
        result = json["result"] == null ? null : Result.fromJson(json["result"]);
        status = json["status"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(result != null) {
            _data["result"] = result?.toJson();
        }
        _data["status"] = status;
        return _data;
    }
}

class Result {
    String? placeId;
    String? formattedAddress;
    Geometry? geometry;
    PlusCode? plusCode;
    Compound? compound;
    String? name;
    String? url;
    List<dynamic>? types;

    Result({this.placeId, this.formattedAddress, this.geometry, this.plusCode, this.compound, this.name, this.url, this.types});

    Result.fromJson(Map<String, dynamic> json) {
        placeId = json["place_id"];
        formattedAddress = json["formatted_address"];
        geometry = json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]);
        plusCode = json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]);
        compound = json["compound"] == null ? null : Compound.fromJson(json["compound"]);
        name = json["name"];
        url = json["url"];
        types = json["types"] ?? [];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["place_id"] = placeId;
        _data["formatted_address"] = formattedAddress;
        if(geometry != null) {
            _data["geometry"] = geometry?.toJson();
        }
        if(plusCode != null) {
            _data["plus_code"] = plusCode?.toJson();
        }
        if(compound != null) {
            _data["compound"] = compound?.toJson();
        }
        _data["name"] = name;
        _data["url"] = url;
        if(types != null) {
            _data["types"] = types;
        }
        return _data;
    }
}

class Compound {
    String? district;
    String? commune;
    String? province;

    Compound({this.district, this.commune, this.province});

    Compound.fromJson(Map<String, dynamic> json) {
        district = json["district"];
        commune = json["commune"];
        province = json["province"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["district"] = district;
        _data["commune"] = commune;
        _data["province"] = province;
        return _data;
    }
}

class PlusCode {
    String? compoundCode;
    String? globalCode;

    PlusCode({this.compoundCode, this.globalCode});

    PlusCode.fromJson(Map<String, dynamic> json) {
        compoundCode = json["compound_code"];
        globalCode = json["global_code"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["compound_code"] = compoundCode;
        _data["global_code"] = globalCode;
        return _data;
    }
}

class Geometry {
    Location? location;

    Geometry({this.location});

    Geometry.fromJson(Map<String, dynamic> json) {
        location = json["location"] == null ? null : Location.fromJson(json["location"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(location != null) {
            _data["location"] = location?.toJson();
        }
        return _data;
    }
}

class Location {
    double? lat;
    double? lng;

    Location({this.lat, this.lng});

    Location.fromJson(Map<String, dynamic> json) {
        lat = json["lat"];
        lng = json["lng"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["lat"] = lat;
        _data["lng"] = lng;
        return _data;
    }
}