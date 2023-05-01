import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/WeatherProvider.dart';
import 'package:weather_app/widget/SavedLocation.dart';
import 'package:weather_app/widget/Search.dart';

class LocationPage extends StatefulWidget {
  final PageController pageController;

  const LocationPage({super.key, required this.pageController});

  @override
  State<LocationPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<LocationPage> {
  bool _isEdit = false;

  @override
  Widget build(BuildContext context) {
    final providerWeather = Provider.of<WeatherProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xff252338),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              // var title = providerWeather.getCurrentWeatherOfLocations;
              // widget.pageController.jumpToPage(0);
              Navigator.pop(context, '');
            },
            child: const Icon(Icons.close)),
        title: const Text("Sửa địa điểm "),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEdit = !_isEdit;
              });
            },
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                foregroundColor: Colors.white),
            child: Text(!_isEdit ? 'Chỉnh sửa' : 'Làm xong'),
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SearchBar(),
              const SizedBox(
                height: 15,
              ),
              if (providerWeather.isLoading)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              SavedLocation(
                  isEdit: _isEdit, pageController: widget.pageController)
            ],
          )),
    );
  }
}
