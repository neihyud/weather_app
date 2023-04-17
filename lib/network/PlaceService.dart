import 'dart:convert';
import 'package:http/http.dart' as http;

// // For storing our result
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

class PlaceApiProvider {
  Future<List<Suggestion>?> fetchSuggestions(String input, String lang) async {
    final String request =
        "https://api.geoapify.com/v1/geocode/autocomplete?text=$input&lang=en&apiKey=480ad5b6c3a7477aa7e7fc4cc38b9bc6";
    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result == null || result['features'] == null) {
        return null;
      }

      return result['features'].map<Suggestion>((p) {
        var placeId = p['properties']['place_id'];
        var formatted = p['properties']['formatted'];
        var lon = p['properties']['lon'];
        var lat = p['properties']['lat'];

        var oldName = p['properties']['oldName'];
        var country = p['properties']['country'];
        var city = p['properties']['city'];

        return Suggestion(placeId, formatted, lon.toString(), lat.toString(),
            oldName, country, city);
      }).toList();
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
