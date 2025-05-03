import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  @override
  void initState() {
    super.initState(); // Moved super.initState() to the top
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.derterminePosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        var city = locationProvider.currentLocationName!.locality;
        if (city != null) {
          Provider.of<WeatherServiceProvider>(context, listen: false)
              .fetchEwatherDataByCity(city);
        }
      }
    });
  }

  // bool _clicked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final weatherProvider = Provider.of<WeatherServiceProvider>(context);
    TextEditingController _cityController = TextEditingController();

    // Get the sunrise timestamp from the API response
    int sunriseTimestamp = weatherProvider.weather?.sys?.sunrise ??
        0; // Replace 0 with a default timestamp if needed
    int sunsetTimestamp = weatherProvider.weather?.sys?.sunset ??
        0; // Replace 0 with a default timestamp if needed

// Convert the timestamp to a DateTime object
    DateTime sunriseDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
    DateTime sunsetDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);

// Format the sunrise time as a string
    String formattedSunrise = DateFormat('hh:mm a').format(sunriseDateTime);
    String formattedSunset = DateFormat('hh:mm a').format(sunsetDateTime);

    // Determine background image with null safety
    String backgroundImagePath = "assets/images/switzerland.jpg"; // default
    if (weatherProvider.weather?.weather?.isNotEmpty == true) {
      String? mainWeather = weatherProvider.weather!.weather![0].main;
      if (mainWeather != null && background[mainWeather] != null) {
        backgroundImagePath = background[mainWeather]!;
      }
    }

    // Determine weather icon image with null safety
    String weatherIconPath = "assets/images/mist.png"; // default
    if (weatherProvider.weather?.weather?.isNotEmpty == true) {
      String? mainWeather = weatherProvider.weather!.weather![0].main;
      if (mainWeather != null && imagePath[mainWeather] != null) {
        weatherIconPath = imagePath[mainWeather]!;
      }
    }

     // Determine greeting based on current time
    String greeting = "";
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour < 12) {
      greeting = "Good Morning";
    } else if (hour < 18) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Evening";
    }

    return Scaffold(
      extendBodyBehindAppBar: true, // full screen background
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(backgroundImagePath), // Using the determined path
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 70,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                          hintText: 'Search by City',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(183, 255, 255, 255)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      weatherProvider
                          .fetchEwatherDataByCity(_cityController.text);
                    },
                    icon: const Icon(Icons.search, size: 28),
                  ),
                ],
              ),
            ),
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
                                text: greeting,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontsize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            // Weather icon/image
            Align(
              alignment: const Alignment(0, -0.5),
              child: Image.asset(
                  width: 100,
                  height: 100,
                  weatherIconPath), // Using the determined path
            ),

            // Temperature and weather condition
            Align(
                alignment: Alignment(0, 0),
                child: Container(
                    height: 150,
                    width: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Temperature with null safety
                        CustomText(
                          text:
                              "${weatherProvider.weather?.main?.temp?.toStringAsFixed(0) ?? "N/A"}°C",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontsize: 30,
                        ),
                        // City name with null safety
                        CustomText(
                          text: weatherProvider.weather?.name ?? "N/A",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontsize: 25,
                        ),
                        // Weather condition with null safety
                        CustomText(
                          text: weatherProvider.weather?.weather?.isNotEmpty ==
                                  true
                              ? weatherProvider.weather!.weather![0].main ??
                                  "N/A"
                              : "N/A",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontsize: 25,
                        ),
                        // Formatted Date Time
                        CustomText(
                          text: DateFormat('hh:mm a').format(DateTime.now()),
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ))),

            // Additional weather details (max/min temp, sunrise/sunset)
            Align(
              alignment: const Alignment(0, .8),
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
                                // Placeholder - you might want to fetch actual max temp
                                CustomText(
                                  text:
                                      "${weatherProvider.weather?.main?.tempMax ?? "N/A"}°C",
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
                                // Placeholder - you might want to fetch actual min temp
                                CustomText(
                                  text:
                                      "${weatherProvider.weather?.main?.tempMin ?? "N/A"}°C",
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
                                // Placeholder - you might want to fetch actual sunrise time
                                CustomText(
                                  text: formattedSunrise,
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
                                // Placeholder - you might want to fetch actual sunset time
                                CustomText(
                                  text: formattedSunset,
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
