import 'package:flutter/material.dart';
import '../network/PlaceService.dart';
import 'package:http/http.dart' as http;

class AddressSearch extends SearchDelegate<Suggestion> {
  PlaceApiProvider apiClient = new PlaceApiProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
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
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title:
                        Text((snapshot.data?[index] as Suggestion).description),
                    onTap: () {
                      close(context, snapshot.data?[index] as Suggestion);
                    },
                  ),
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
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text('Empty'),
    );

    throw UnimplementedError();
  }
}
