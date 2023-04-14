import 'package:flutter/material.dart';
// import '../models/Suggestion.dart';
import '../network/PlaceService.dart';
import 'package:http/http.dart' as http;

import 'PopularLocation.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  PlaceApiProvider apiClient = new PlaceApiProvider();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.white,
      hintColor: Colors.grey,
      primarySwatch: Colors.blueGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
        filled: true,
        fillColor: Colors.grey[200],
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.search),
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
              child: locationPopulation(context),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text((snapshot.data?[index] as Suggestion).formatted),
                      onTap: () {
                        close(context, snapshot.data?[index] as Suggestion);
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
    return InkWell(
        onTap: () => {Navigator.pop(context)},
        child: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text('Empty'),
    );
  }
}
