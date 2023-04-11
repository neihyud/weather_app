import 'package:flutter/material.dart';

@override
Widget locationPopulation() {
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
            // width: MediaQuery.of(context).size.width,
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
