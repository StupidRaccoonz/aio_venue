import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/screens/authentication/wrapper.dart';
import 'package:aio_sport/screens/venue/venue_main_page.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key});

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  @override
  void initState() {
    super.initState();
    if (getStorage.read<bool>(Constants.isNewAccount) ?? false) {
      getStorage.write(Constants.lastPage, "/");
      getStorage.write(Constants.isNewAccount, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Opacity(
                opacity: 0.05,
                child: Image.asset(
                  "assets/images/trophy.png",
                  width: constraints.maxWidth * 0.75,
                ),
              ),
              Image.asset(
                "assets/images/confetti.png",
                width: double.maxFinite,
              ),
              Image.asset(
                "assets/images/trophy.png",
                height: constraints.maxWidth * 0.35,
              ),
            ],
          ),
          Center(child: Text("Congratulations!", style: Get.textTheme.displayLarge)),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Text("Your venue is successfully registered with us now see wait and see the magic. ",
                style: Get.textTheme.labelLarge, textAlign: TextAlign.center),
          )),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: MyButton(
              text: "Go to home",
              onPressed: () => Get.to(() => const VenueMainPage()),
            ),
          ),
        ],
      );
    }));
  }
}
