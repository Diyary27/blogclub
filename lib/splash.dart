import 'package:blogclub/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (context) {
        return MyHomeScreen();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Assets.img.background.splash.image(fit: BoxFit.cover),
          ),
          Center(
            child: Assets.img.icons.logo.svg(
                width: 110,
                theme:
                    SvgTheme()), // or SvgPicture.asset(Assets.img.icons.logo.keyName)
          ),
        ],
      ),
    );
  }
}
