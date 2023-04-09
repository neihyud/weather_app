class Suggestion {
  List<Predictions>? predictions;

  Suggestion({this.predictions});

  Suggestion.fromJson(Map<String, dynamic> json) {
    predictions = json["predictions"] == null
        ? null
        : (json["predictions"] as List)
            .map((e) => Predictions.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (predictions != null) {
      _data["predictions"] = predictions?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Predictions {
  String? description;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;

  Predictions(
      {this.description,
      this.placeId,
      this.reference,
      this.structuredFormatting});

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json["description"];
    placeId = json["place_id"];
    reference = json["reference"];
    structuredFormatting = json["structured_formatting"] == null
        ? null
        : StructuredFormatting.fromJson(json["structured_formatting"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["description"] = description;
    _data["place_id"] = placeId;
    _data["reference"] = reference;
    if (structuredFormatting != null) {
      _data["structured_formatting"] = structuredFormatting?.toJson();
    }
    return _data;
  }
}

class StructuredFormatting {
  String? mainText;
  String? secondaryText;

  StructuredFormatting({this.mainText, this.secondaryText});

  StructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json["main_text"];
    secondaryText = json["secondary_text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["main_text"] = mainText;
    _data["secondary_text"] = secondaryText;
    return _data;
  }
}
