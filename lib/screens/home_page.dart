import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/data/image_path.dart';
import 'package:weather_app_provider/services/location_Provider.dart';
import 'package:weather_app_provider/services/weather_service_provider.dart';
import '../utils/customText.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _clicked = false;

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).derterminePosition();
    Provider.of<WeatherServiceProvider>(context, listen: false)
        .fetchEwatherDataByCity("Dubai");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true, // full screen background
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Container(
        padding:
            const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(background[2]),
          ),
        ),
        child: Stack(
          children: [
            // Search bar appears when _clicked is true
            _clicked
                ? Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Container(
                      child: const TextField(
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),

            // Location info and search button
            Container(
              height: 50,
              child: Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
                  var locationCity;
                  if (locationProvider.currentLocationName != null) {
                    locationCity =
                        locationProvider.currentLocationName!.locality;
                  } else {
                    locationCity = "Unknown";
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Location icon and name
                      Row(
                        children: [
                          const Icon(Icons.location_pin, color: Colors.red),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: locationCity,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontsize: 18,
                              ),
                              CustomText(
                                text: "Good Morning",
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontsize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Search icon button
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _clicked = true;
                          });
                        },
                        icon: const Icon(Icons.search, size: 32),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Weather icon/image
            Align(
              alignment: const Alignment(0, -0.5),
              child: Image.asset(height: 100, width: 100, imagePath[4]),
            ),

            // Temperature and weather condition
            Align(
              alignment: Alignment(0, 0),
              child: Container(
                height: 130,
                width: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: "21 °C",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontsize: 30,
                    ),
                    const CustomText(
                      text: "Snow",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontsize: 25,
                    ),
                    CustomText(
                      text: DateTime.now().toString(),
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Additional weather details (max/min temp, sunrise/sunset)
            Align(
              alignment: const Alignment(0, 0.9),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Colors.transparent.withOpacity(0.5),
                ),
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Max and Min temperature
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                                height: 40, "assets/images/temp_high.png"),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Temp Max",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                const CustomText(
                                  text: "21 °C",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            Image.asset(
                                height: 40, "assets/images/temp-low.png"),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Temp Min",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                const CustomText(
                                  text: "18 °C",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      height: 10,
                      indent: 60,
                      endIndent: 60,
                    ),
                    const SizedBox(height: 10),
                    // Sunrise and Sunset info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(height: 40, "assets/images/sun.png"),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Sunrise",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                const CustomText(
                                  text: "6:00 AM",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            Image.asset(height: 40, "assets/images/moon.png"),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Sunset",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                const CustomText(
                                  text: "8:00 PM",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
