import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather_app/src/core/models/weather_models.dart';
import 'package:weather_app/src/core/services/weather_services.dart';

import 'widgets/bottom_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  
  String cityName = "Jakarta";
  WeatherServices services = WeatherServices();
  Weather? data;

  Future<void> getData() async {
    data = await services.getCurrentWeather(cityName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getTime() {
    var hour = DateTime.now().hour;
    if (hour > 6 && hour < 12) {
      return "assets/images/morning.png";
    } else if (hour > 12 && hour < 18) {
      return "assets/images/sunset.png";
    } else {
      return "assets/images/night.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              getTime(),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.black38,
            ),
          ),
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0, bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${data!.cityName}".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                          ),
                        ),
                        Text(
                          "${data!.temp} K",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 42.0,
                          ),
                        ),
                        Text(
                          "Feels like ${data!.feelsLike} K",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: const BorderSide(
                                  color: Colors.white
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: const BorderSide(
                                  color: Colors.white
                                ),
                                gapPadding: 16.0
                              ),
                              labelText: "Search City",
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              suffixIcon: const Icon(
                                Icons.search_rounded,
                                color: Colors.white,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              cityName = _controller.text;
                              _controller.clear();
                            });
                          },
                          child: const Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.black12,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BottomItem(
                          label: "Humidity",
                          unit: "%",
                          value: "${data!.humidity}",
                        ),
                        BottomItem(
                          label: "Wind",
                          unit: "m/s",
                          value: "${data!.wind}",
                        ),
                        BottomItem(
                          label: "Pressure",
                          unit: "hPa",
                          value: "${data!.pressure}",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.refresh_rounded,
            ),
            label: "Refresh",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.exit_to_app_rounded,
            ),
            label: "Exit",
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            setState(() {});
          } else {
            exit(0);
          }
        },
      )
    );
  }
}