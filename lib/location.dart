import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<LocationPage> {
  bool _isEdit = false;
  bool _isOpenMap = false;

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
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/img/location_background.png"),
          //     fit: BoxFit.cover,
          //   ),
          //   // color: Color(0xff384252),
          //   // color: Color.fromARGB(255, 0, 0, 0),
          // ),
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
                popularLocation(),
            ],
          )),
    );
  }
}

// ignore: camel_case_types
class popularLocation extends StatelessWidget {
  const popularLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> location = [
      "Hanoi",
      "Nepal",
      "India",
      "China",
      "USA",
      "Canada",
      "Brazil",
    ];
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                "VỊ TRÍ XUNG QUANH",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  // color: Colors.white
                ),
              ),
              Icon(
                Icons.location_pin,
                // color: Colors.white,
              )
            ],
          ),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 201, 149, 82),
                  border: Border.all(
                      color: Colors.black12,
                      width: 1.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(100)),
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Row(
                children: [
                  IconButton(
                    icon: new Icon(Icons.location_pin),
                    alignment: Alignment.center,
                    padding: new EdgeInsets.all(0.0),
                    onPressed: () {},
                  ),
                  Text("Cho phép Quyền vị trí",
                      style: TextStyle(fontWeight: FontWeight.w600))
                ],
              )),
          SizedBox(height: 10),
          Row(
            children: [
              Text("CÁC VỊ TRÍ PHỔ BIẾN",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              Icon(Icons.local_fire_department)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black12,
                      width: 1.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)),
              child: GridView.count(
                  childAspectRatio: (1 / .3),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  // primary: false,
                  // padding: const EdgeInsets.all(20),
                  // crossAxisSpacing: 10,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                  children: location.map((e) {
                    return day();
                  }).toList()),
            ),
          )
        ],
      ),
    );
  }

  Widget day() {
    return const ListTile(
      title: Text("Hanoi"),
      subtitle: Text("Hanoi/VietName"),
    );
  }
}

// ignore: camel_case_types
class listLocation extends StatefulWidget {
  final bool isEdit;

  const listLocation({super.key, required this.isEdit});

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
            for (int index = 0; index < daysFor.length; index += 1) day(index)
          ]),
    );
  }

  Widget day(index) {
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
                        SizedBox(
                          width: 10,
                        ),
                        Text(
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
          ),
        )
      ],
    );
  }
}
