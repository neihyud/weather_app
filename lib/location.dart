import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        leading: Icon(Icons.close),
        title: Text("Sửa địa điểm "),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Chỉnh sửa'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          )
        ],
      ),
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
              // Container(
              //   height: 100,
              //   width: 100,
              //   decoration:
              //       BoxDecoration(color: Color.fromARGB(255, 2502, 25, 25)),
              // ),
              SearchBar(
                onSearch: (String) {},
              ),
              listLocation(),
              popularLocation()
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
          Container(
              width: MediaQuery.of(context).size.width,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 201, 149, 82),
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
    return ListTile(
      title: Text("Hanoi"),
      subtitle: Text("Hanoi/VietName"),
    );
  }
}

// ignore: camel_case_types
class listLocation extends StatelessWidget {
  const listLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> daysFor = [
      "Brazil",
      "Nepal",
      "India",
    ];
    return Column(
      children: daysFor.map((dayFor) {
        return day();
      }).toList(),
    );
  }

  Widget day() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Color.fromARGB(255, 2, 2, 2),
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10)), 
      height: 100,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
        )
      ]),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          alignment: Alignment.center,
          padding: new EdgeInsets.all(0.0),
          constraints: BoxConstraints(),
          onPressed: () {
            Navigator.pop(context);
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
                  widget.onSearch(_searchController.text);
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
