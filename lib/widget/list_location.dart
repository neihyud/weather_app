import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Geometry.dart';

// ignore: camel_case_types
class listLocation extends StatefulWidget {
  final bool isEdit;

  final List<Map<String, dynamic>> data;
  const listLocation({super.key, required this.isEdit, required this.data});

  @override
  State<listLocation> createState() => _listLocationState();
}

// ignore: camel_case_types
class _listLocationState extends State<listLocation> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<List<Geometry>> _geo;

  List<String> daysFor = [
    "Brazil",
    "Nepal",
    "India",
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   _geo = _prefs.then((SharedPreferences prefs) {
  //     // return ""prefs.getStringList("geo");
  //     return null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print("data $widget.data");
    return Expanded(
      child: ReorderableListView(
          // buildDefaultDragHandles: false,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final String item = daysFor.removeAt(oldIndex);
              daysFor.insert(newIndex, item);
            });
          },
          children:
              // daysFor.map((dayFor) {
              //   return day();
              // }).toList(),
              [
            for (int index = 0; index < daysFor.length; index += 1)
              day(index, daysFor[index])
          ]),
    );
  }

  Widget day(int index, String day) {
    return Row(key: Key('$index'), children: [
      if (widget.isEdit) Icon(Icons.home),
      Flexible(
        flex: 1,
        child: Stack(children: [
          Container(
            margin: widget.isEdit
                ? EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                : EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: Color.fromARGB(255, 2, 2, 2),
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10)),
            height: 100,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${day}",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "3/10    09:18",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(children: [
                        Icon(Icons.cloudy_snowing),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "22 C",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )
                      ]),
                      Text(
                        "Cloud",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ]),
          ),
          if (widget.isEdit)
            Positioned(
              top: 6,
              right: 14,
              child: GestureDetector(
                onTap: () {
                  print("delete location");
                },
                child: Icon(
                  Icons.remove_circle,
                  size: 20,
                ),
              ),
            ),
        ]),
      ),
      if (widget.isEdit)
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromARGB(255, 160, 178, 207)),
          padding: EdgeInsets.all(3),
          child: ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_handle),
          ),
        ),
    ]);
  }
}
