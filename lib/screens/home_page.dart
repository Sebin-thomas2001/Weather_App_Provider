import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/data/image_path.dart';
import 'package:weather_app_provider/services/location_Provider.dart';
import '../utils/customText.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<LocationProvider>(context, listen: false).derterminePosition();
    super.initState();
  }

  bool _clicked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true, // used to full screen
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
          image: AssetImage(
            background[2],
          ),
        )),
        child: Stack(
          children: [
            _clicked == true
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
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: const Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Dubai",
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontsize: 18,
                            ),
                            CustomText(
                              text: "Good Morning",
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontsize: 14,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _clicked = true;
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.5),
              child: Image.asset(height: 100, width: 100, imagePath[4]),
            ),
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
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.9),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: Colors.transparent.withOpacity(0.5)),
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Row(
                        children: [
                          Image.asset(
                              height: 40, "assets/images/temp_high.png"),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
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
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Image.asset(height: 40, "assets/images/temp-low.png"),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
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
                          )
                        ],
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 10,
                      indent: 60,
                      endIndent: 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Row(
                        children: [
                          Image.asset(height: 40, "assets/images/sun.png"),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Sunrise",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              const CustomText(
                                text: "21 °C",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Image.asset(height: 40, "assets/images/moon.png"),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Sunset",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              const CustomText(
                                text: "21 °C",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          )
                        ],
                      ),
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
