import 'package:blogclub/article.dart';
import 'package:blogclub/data.dart';
import 'package:blogclub/gen/assets.gen.dart';
import 'package:blogclub/gen/fonts.gen.dart';
import 'package:blogclub/profile.dart';
import 'package:blogclub/splash.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'carousel/carousel_slider.dart';
import 'home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static String defaultFontFamily = FontFamily.avenir;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Color primaryTextColor = Color(0xff0D253C);
    final Color secondoryTextColor = Color(0xff2D4379);
    final Color primaryColor = Color(0xff376AED);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          onPrimary: Colors.white,
          onSurface: primaryTextColor,
          background: Color(0xffFBFCFF),
          surface: Colors.white,
          onBackground: primaryTextColor,
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w200,
            fontSize: 18,
            color: secondoryTextColor,
          ),
          headlineMedium: TextStyle(
            fontFamily: defaultFontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: primaryTextColor,
          ),
          headlineSmall: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          titleLarge: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: primaryTextColor,
          ),
          titleSmall: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: primaryTextColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: defaultFontFamily,
            color: secondoryTextColor,
            fontSize: 12,
          ),
          bodySmall: TextStyle(
            fontFamily: defaultFontFamily,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xff7B8BB2),
          ),
          bodyLarge: TextStyle(
            fontFamily: defaultFontFamily,
            fontSize: 14,
            color: primaryTextColor,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: primaryTextColor,
          titleSpacing: 32,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: primaryColor,
        ),
      ),
      // home: Stack(children: [
      //   Positioned.fill(child: MyHomeScreen()),
      //   Positioned(
      //     bottom: 0,
      //     right: 0,
      //     left: 0,
      //     child: _BottomNavigation(),
      //   ),
      // ]),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

const homeIndex = 0;
const articleIndex = 1;
const searchIndex = 2;
const profileIndex = 3;
const double bottomNavigationHeight = 65;

class _MainScreenState extends State<MainScreen> {
  int selectedTabIndex = homeIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: bottomNavigationHeight,
            child: IndexedStack(
              index: selectedTabIndex,
              children: [
                HomeScreen(),
                ArticleScreen(),
                SearchScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: _BottomNavigation(
              onTap: (int index) {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              selectedIndex: selectedTabIndex,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Search Box',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  final Function(int index) onTap;
  final int selectedIndex;

  const _BottomNavigation(
      {super.key, required this.onTap, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: bottomNavigationHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      color: Color(0xff9b8487).withOpacity(0.14)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavigationIcon(
                    iconFileName: 'Home.png',
                    activeIconFileName: 'HomeActive.png',
                    title: 'Home',
                    onTap: () {
                      onTap(homeIndex);
                    },
                    isActivate: selectedIndex == homeIndex,
                  ),
                  BottomNavigationIcon(
                    iconFileName: 'Articles.png',
                    activeIconFileName: 'ArticlesActive.png',
                    title: 'Articles',
                    onTap: () {
                      onTap(articleIndex);
                    },
                    isActivate: selectedIndex == articleIndex,
                  ),
                  Expanded(
                    child: SizedBox(width: 5),
                  ), /////////////////////////////   very important
                  BottomNavigationIcon(
                    iconFileName: 'Search.png',
                    activeIconFileName: 'SearchActive.png',
                    title: 'Search',
                    onTap: () {
                      onTap(searchIndex);
                    },
                    isActivate: selectedIndex == searchIndex,
                  ),
                  BottomNavigationIcon(
                    iconFileName: 'Menu.png',
                    activeIconFileName: 'MenuActive.png',
                    title: 'Menu',
                    onTap: () {
                      onTap(profileIndex);
                    },
                    isActivate: selectedIndex == profileIndex,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              height: 85,
              width: 65,
              alignment: Alignment.topCenter,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xff376aed),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    )),
                child: Image.asset('assets/img/icons/plus.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavigationIcon extends StatelessWidget {
  final String iconFileName;
  final String activeIconFileName;
  final String title;
  final bool isActivate;
  final Function() onTap;

  const BottomNavigationIcon(
      {super.key,
      required this.iconFileName,
      required this.activeIconFileName,
      required this.title,
      required this.onTap,
      required this.isActivate});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/img/icons/${isActivate ? activeIconFileName : iconFileName}'),
            SizedBox(height: 4),
            Text(
              title,
              style: isActivate
                  ? themeData.textTheme.bodySmall!
                      .copyWith(color: themeData.colorScheme.primary)
                  : themeData.textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
