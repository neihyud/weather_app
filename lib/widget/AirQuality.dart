import 'package:flutter/material.dart';
import 'package:weather_app/models/AirQuality.dart';

Widget infoWeather(AirQuality airQuality) {
  int idx_hour = DateTime.now().hour;
  var pm10 = airQuality.hourly?.pm10?[idx_hour];
  var co = airQuality.hourly?.carbonMonoxide?[idx_hour];
  var no2 = airQuality.hourly?.nitrogenDioxide?[idx_hour];
  var so2 = airQuality.hourly?.sulphurDioxide?[idx_hour];
  var o3 = airQuality.hourly?.ozone?[idx_hour];
  var pm2 = airQuality.hourly?.pm25?[idx_hour];
  var uv = airQuality.hourly?.uvIndex?[idx_hour];
  var dust = airQuality.hourly?.dust?[idx_hour];

  return Container(
    // height: 125,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(50, 56, 66, 82),
    ),
    padding: EdgeInsets.all(10),
    child: Column(
      children: [
        const Text(
          "Chất lượng không khí",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '',
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'PM\u2081\u2080 :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text: "${pm10} μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'PM\u2082.\u2085 :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text: "${pm2} μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'NO\u2082 :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text: "${no2} μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'SO\u2082 :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text: "${so2} μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '',
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'O\u2083 :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text: "${o3} μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'CO :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text: "${co} μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'UV :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text: "${uv}",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Bụi :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text: "${dust} μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
            ],
          )
        ])
      ],
    ),
  );
}
