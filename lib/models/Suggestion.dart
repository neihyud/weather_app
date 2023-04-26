class Suggestion {
  final String placeId;
  final String formatted;
  final String lon;
  final String lat;

  String? oldName;
  String? country;
  String? city;
  Suggestion(this.placeId, this.formatted, this.lon, this.lat, this.city,
      this.country, this.oldName);

  @override
  String toString() {
    return 'Suggestion(description: $formatted, placeId: $placeId)';
  }
}
