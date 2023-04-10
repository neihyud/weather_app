import 'package:flutter/material.dart';
// import '../models/Suggestion.dart';
import '../network/PlaceService.dart';
import 'package:http/http.dart' as http;

class AddressSearch extends SearchDelegate<Suggestion> {
  PlaceApiProvider apiClient = new PlaceApiProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          // (snapshot.data?[index]?['properties'])['formatted']),
                          "${(snapshot.data?[index] as Suggestion).formatted}"),
                      onTap: () {
                        close(
                            context,
                            // snapshot.data?[index]?['properties'] as Suggestion);
                            snapshot.data?[index] as Suggestion);
                      },
                    );
                  },
                  itemCount: snapshot.data?.length,
                )
              : Container(child: Text('Loading...')),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // var result = null;
        Navigator.pop(context);
        // close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text('Empty'),
    );
  }
}
