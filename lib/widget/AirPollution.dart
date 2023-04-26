import 'package:flutter/material.dart';
import 'package:weather_app/helper/description_air_pollution.dart';
import 'package:weather_app/models/AirPollution.dart';

Widget infoAirPollution(AirPollution airPollution) {
  var pm10 = airPollution.components?.pm10;
  var co = airPollution.components?.co;
  var no2 = airPollution.components?.no2;
  var so2 = airPollution.components?.so2;
  var o3 = airPollution.components?.o3;
  var pm2 = airPollution.components?.pm25;
  var nh3 = airPollution.components?.nh3;
  var no = airPollution.components?.no;
  var aqi = airPollution.main?.aqi;

  return Container(
    // height: 125,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(40, 255, 255, 255),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        const Text(
          "Chất lượng không khí",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
        ),
        const SizedBox(height: 10),
        getDesAirPopulation(aqi.toString()),
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
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    TextSpan(
                        text: "$pm10 μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
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
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    TextSpan(
                        text: "$pm2 μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
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
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    TextSpan(
                        text: "$no2 μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
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
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    TextSpan(
                        text: "$so2 μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
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
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    TextSpan(
                        text: "$o3 μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
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
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    TextSpan(
                        text: "$co μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
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
                        text: 'NO :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    TextSpan(
                        text: "$no μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
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
                        text: 'NH\u2083 :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    TextSpan(
                        text: "$nh3 μg/m³",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
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
