import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rd_test_flutter_heroes/views/heroes_list_ui.dart';

void main() {
  runApp(const GetMaterialApp(
    home: SplashUI(),
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
  ));
}

class SplashUI extends StatelessWidget {
  const SplashUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<_SplashController>(
        init: _SplashController(),
        builder: (controller) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(
                    'assets/marvel.svg',
                    width: size.width * 0.5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 0.1),
                  ),
                  SvgPicture.asset(
                    'assets/dc.svg',
                    width: size.width * 0.35,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      const Duration(seconds: 2),
      () => Get.off(const HeroesListUI()),
    );
  }
}
