import 'package:flutter/material.dart';
import 'location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: ListTile(
          //   title: Center(
          //       child: Row(children: const [Text('Title'), Icon(Icons.bolt)])),
          //   subtitle: const Center(child: Text('Subtitle')),
          //   onTap: () {},
          // ),
          // elevation: ,
          ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(child: Text("Weather")),
            buildMenuItem()
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: const <Widget>[
            infoForeCastCurrent(),
            SizedBox(height: 10),
            hourlyForeCast(),
            SizedBox(height: 10),
            dailyForeCast(),
            SizedBox(height: 10),
            infoForeCast()
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class infoForeCastCurrent extends StatelessWidget {
  const infoForeCastCurrent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(50, 56, 66, 82),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Mua"),
            Text(
              "28 C",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.w800),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nhiệt độ"),
                SizedBox(width: 8),
                Text("2C"),
                SizedBox(width: 8),
                Icon(Icons.arrow_drop_down),
                Text("2C"),
                SizedBox(width: 8),
                Icon(Icons.arrow_drop_up),
                Text("4C"),
              ],
            )
          ]),
    );
  }
}

// ignore: camel_case_types
class infoForeCast extends StatelessWidget {
  const infoForeCast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      // padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(20, 22, 44, 33),
          ),
          padding: const EdgeInsets.all(8),
          child: const Text("He'd have you all unravel at the"),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(20, 22, 44, 33),
          ),
          child: const Text('Heed not the rabble'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(20, 22, 44, 33),
          ),
          child: const Text('Sound of screams but the'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(20, 22, 44, 33),
          ),
          child: const Text('Who scream'),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class dailyForeCast extends StatelessWidget {
  const dailyForeCast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> daysFor = [
      "Brazil",
      "Nepal",
      "India",
      "China",
      "USA",
      "Canada",
      "Brazil",
    ];
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(50, 56, 66, 82),
        ),
        child: Column(
          children: daysFor.map((dayFor) {
            return day();
          }).toList(),
        ));
  }

  Widget day() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Today"),
        Icon(Icons.cloud),
        Wrap(
          spacing: 12.0,
          children: [
            Text("19 C"),
            Text("29 C"),
          ],
        )
      ]),
    );
  }
}

// ignore: camel_case_types
class hourlyForeCast extends StatelessWidget {
  const hourlyForeCast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> countries = [
      "13:00",
      "14:00",
      "15:00",
      "16:00",
      "17:00",
      "18:00",
      "19:00",
      "20:00",
      "21:00",
    ];
    return Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(50, 56, 66, 82),
        ),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: countries.map((country) {
                return box(country, Colors.transparent);
              }).toList(),
            )));
  }

  Widget box(String title, Color backgroundcolor) {
    return Container(
        margin: EdgeInsets.all(10),
        color: backgroundcolor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
            // Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Icon(
              Icons.cloudy_snowing,
              size: 45,
            ),
            // Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Text('25°C', style: TextStyle(color: Colors.white, fontSize: 18))
          ],
        ));
  }
}

// ignore: camel_case_types
class buildMenuItem extends StatelessWidget {
  const buildMenuItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Sửa địa điểm'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LocationPage();
          }));
        },
      ),
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Item 1'),
        onTap: () {},
      ),
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Item 1'),
        onTap: () {},
      ),
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Vote'),
        onTap: () {},
      ),
    ]);
  }
}
