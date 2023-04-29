import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/helper/background_code.dart';
import 'package:weather_app/models/CurrentForecast.dart';
import 'package:weather_app/provider/WeatherProvider.dart';
import 'WeatherPageView.dart';
import 'database/database_helper.dart';
import 'location.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsApp.debugAllowBannerOverride = false;
  await dbHelper.init();
  await dotenv.load(fileName: "lib/.env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  bool _isLoading = false;
  String title = '';
  String code = '';

  int currentIndex = 0;

  late List<Widget> weatherWidgets;

  List<dynamic> detailDataOAllPageView = [];

  changePage(index) {
    // CurrentForeCast currentForeCast =  CurrentForeCast.fromJson(jsonDecode(detailDataOfPageView[index][0].body))  ;
    CurrentForeCast currentForeCast = detailDataOAllPageView[index][0];
    setState(() {
      title = currentForeCast.name!;
      code = currentForeCast.weather![0].icon!;
    });
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<WeatherProvider>(context, listen: false)
        .getDetailDataOfAllPageView()
        .then((data) {
      List<dynamic> data_ = [...data];
      weatherWidgets = data_.map((dataWeather) {
        return WeatherPageView(data: dataWeather);
      }).toList();

      setState(() {
        _isLoading = false;

        detailDataOAllPageView =
            Provider.of<WeatherProvider>(context, listen: false)
                .getDetailDataOfAllPageWeather;

        CurrentForeCast currentForeCast = detailDataOAllPageView[0][0];
        title = currentForeCast.name!;
        code = currentForeCast.weather![0].icon!;
      });
    });

    Provider.of<WeatherProvider>(context, listen: false)
        .savedLocationForecast();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: const Alignment(1, 1),
        colors: getBackgroundColor(code),
        tileMode: TileMode.mirror,
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LocationPage(pageController: _pageController,);
                  }));
                },
                child: const Icon(Icons.add)),
            centerTitle: true,
            title: Text(title),
          ),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : PageView(
                  onPageChanged: (index) {
                    changePage(index);
                  },
                  controller: _pageController,
                  children: weatherWidgets,
                )),
    );
  }

  // void navigateToPage(int pageIndex) {
  //   _pageController.animateToPage(
  //     pageIndex,
  //     duration: Duration(milliseconds: 500),
  //     curve: Curves.easeInOut,
  //   );
  // }
}
