import 'dart:convert';
import 'dart:io';
// import '../models/Suggestion.dart';
import 'package:http/http.dart' as http;
import '../models/LocationDetail.dart';


class Place {
  var lat;
  var lng;

  Place({
    this.lat,
    this.lng,
  });

  @override
  String toString() {
    return 'Place(lat: $lat, lng: $lng)';
  }
}

// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  Future<List<Suggestion>?> fetchSuggestions(String input, String lang) async {
    final String request =
        'https://rsapi.goong.io/Place/AutoComplete?api_key=bi8HxGWnMPaASzQp2hQebJBwG2wRQfhyXaBeHdal&input=$input';
    // final response = await client.get(request as Uri);
    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['predictions'] == null) {
        // List<Suggestion> test ;
        return null;
      }

      return result['predictions']
          .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
          .toList();
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<LocationDetail?> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://rsapi.goong.io/Place/Detail?place_id=$placeId&api_key=bi8HxGWnMPaASzQp2hQebJBwG2wRQfhyXaBeHdal';

    final response = await http.get(Uri.parse(request));

    LocationDetail locationDetail = new LocationDetail();

    if (response.statusCode == 200) {
      // final result = json.decode(response.body);
      final result2 = LocationDetail.fromJson(jsonDecode(response.body));
      locationDetail = result2;

      return locationDetail;

    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
