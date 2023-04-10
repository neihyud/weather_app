import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/AirQuality.dart';
import 'database/database_helper.dart';
import 'location.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/network/WeatherApiClient.dart';
import 'package:weather_app/widget/current_weather.dart';
import 'package:weather_app/widget/daily_weather.dart';
import 'package:weather_app/widget/hourly_weather.dart';
import 'package:weather_app/widget/air_quality.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  await dotenv.load(fileName: "lib/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  Weather weather = new Weather();
  AirQuality airQuality = new AirQuality();
  var isLoaded = false;

  Future<void> getData() async {
    weather = await WeatherApiClient().getWeather();
    airQuality = await WeatherApiClient().getAirQuality();
  }

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
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  currentWeather(weather),
                  const SizedBox(height: 16),
                  hourlyWeather(weather),
                  const SizedBox(height: 16),
                  dailyWeather(weather),
                  const SizedBox(height: 16),
                  infoWeather(airQuality),
                ],
              ),
            );
          },
        ));
  }
}

// ignore: camel_case_types
// class infoForeCast extends StatelessWidget {
//   const infoForeCast({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       // scrollDirection: Axis.vertical,
//       shrinkWrap: true,
//       primary: false,
//       // padding: const EdgeInsets.all(20),
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       crossAxisCount: 2,
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Color.fromARGB(20, 22, 44, 33),
//           ),
//           padding: const EdgeInsets.all(8),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Row(
//               children: [Icon(Icons.air), Text("Gió")],
//             ),
//             Expanded(
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "17",
//                       style: TextStyle(fontSize: 70),
//                     ),
//                   ]),
//             )
//           ]),
//         ),
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Color.fromARGB(20, 22, 44, 33),
//           ),
//           child: const Text('Heed not the rabble'),
//         ),
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Color.fromARGB(20, 22, 44, 33),
//           ),
//           child: const Text('Sound of screams but the'),
//         ),
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Color.fromARGB(20, 22, 44, 33),
//           ),
//           child: const Text('Who scream'),
//         ),
//       ],
//     );
//   }
// }

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
