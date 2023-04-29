import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/WeatherProvider.dart';
import 'package:weather_app/widget/SavedLocation.dart';
import 'package:weather_app/widget/Search.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<LocationPage> {
  bool _isEdit = false;
  bool _isLoading = false;

  loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 68, 70, 124),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
              if (weatherData.isLoading)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              SavedLocation(isEdit: _isEdit, isLoading: _isLoading)
            ],
          )),
    );
  }
}
