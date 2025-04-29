import 'package:flutter/material.dart';
import 'package:weather_app_provider/data/image_path.dart';
import '../utils/customText.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            background[0],
          ),
        )),
        child: Stack(
          children: [
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
                    onPressed: () {},
                    icon: const Icon(Icons.search,
                    size: 32,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
