import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Suggestion.dart';

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
