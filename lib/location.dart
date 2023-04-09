import 'package:flutter/material.dart';
import 'package:weather_app/widget/address_search.dart';
import 'package:weather_app/widget/popular_location.dart';
import 'package:weather_app/widget/list_location.dart';
import 'package:weather_app/network/PlaceService.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/database/test2.dart';


class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<LocationPage> {
  
  bool _isEdit = false;
  bool _isOpenMap = false;

  DatabaseHelper db = DatabaseHelper();
  List<Map<String, dynamic>> data = await db.getData("my_table");

  openMap() {
    setState(() {
      _isOpenMap = !_isOpenMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: !_isOpenMap
          ? AppBar(
              // backgroundColor: Colors.transparent,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close)),
              title: Text("Sửa địa điểm "),
              elevation: 0,
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isEdit = !_isEdit;
                    });
                  },
                  child: Text(!_isEdit ? 'Chỉnh sửa' : 'Làm xong'),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                )
              ],
            )
          : null,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchBar(
                onSearch: (String) {},
                openMap: openMap,
                isOpenMap: _isOpenMap,
              ),
              if (!_isOpenMap)
                listLocation(
                  isEdit: _isEdit,
                )
              else
                locationPopulation(),
            ],
          )),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function() openMap;
  final Function(String) onSearch;

  final bool isOpenMap;

  const SearchBar(
      {Key? key,
      required this.onSearch,
      required this.openMap,
      required this.isOpenMap})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_apiO
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();
  // final bool isOpenMap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.isOpenMap)
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0.0),
            constraints: const BoxConstraints(),
            onPressed: () {
              // Navigator.pop(context);
              widget.openMap();
            },
          ),
        // Icon(Icons.arrow_back_ios),
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              filled: true, //<-- SEE HERE
              // fillColor: Color.fromARGB(255, 43, 38, 56), //<-- SEE HERE
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
              suffixIcon: IconButton(
                icon: Icon(Icons.map),
                onPressed: () {
                  // widget.isOpenMap = !isOpenMap;
                  widget.onSearch(_searchController.text);
                  widget.openMap();
                },
              ),
            ),
            onTap: () async {
              final Suggestion? result = await showSearch(
                context: context,
                delegate: AddressSearch(),
              );
              // This will change the text displayed in the TextField
              if (result != null) {
                final placeDetails = await PlaceApiProvider()
                    .getPlaceDetailFromId(result.placeId);

                print("placeDeatils $placeDetails");
                setState(() {});
              }
            },
          ),
        )
      ],
    );
  }
}
