import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Geometry.dart';
import '../helper/description_code.dart';
import '../helper/icon_weather.dart';

class SavedLocation extends StatefulWidget {
  final bool isEdit;
  final List<Weather> data;
  const listLocation({super.key, required this.isEdit, required this.data});

  @override
  State<listLocation> createState() => _listLocationState();
}

// ignore: camel_case_types
class _listLocationState extends State<listLocation> {
  List<String> daysFor = [
    "Brazil",
    "Nepal",
    "India",
  ];

  @override
  Widget build(BuildContext context) {
    print("dataListLocationSTate: ${widget.data.length}");
    return Expanded(
      child: ReorderableListView(
          // buildDefaultDragHandles: false,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final Weather item = widget.data.removeAt(oldIndex);
              widget.data.insert(newIndex, item);
            });
          },
          children: [
            for (int index = 0; index < widget.data.length; index += 1)
              day(index, widget.data[index])
          ]),
    );
  }

  Widget day(int index, Weather forecast) {
    var temp = forecast.currentWeather?.temperature;
    var time = forecast.currentWeather?.time;
    var weatherCode = forecast.currentWeather?.weathercode;
    DateTime datetime = DateTime.parse(time!);

    var day = "${datetime.day}".padLeft(2, '0');
    var month = "${datetime.month}".padLeft(2, '0');

    var hour = "${datetime.hour}".padLeft(2, '0');
    var minute = "${datetime.minute}".padLeft(2, '0');

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
                        "Hanoi",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "$day/$month    $hour:$minute",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(children: [
                        // Icon(Icons.cloudy_snowing),
                        getIcon(weatherCode.toString()),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${temp?.round()}  °C",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )
                      ]),
                      getDesCode(weatherCode.toString())
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
