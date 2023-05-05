import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:authapp/constants/constants.dart';
import 'package:authapp/views/screens/screens.dart';

import 'package:authapp/views/widgets/widgets.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List _screens = [
    HomeScreen(),
    SecondScreen(),
    Container(
        child: Center(
      child: Text("third screen"),
    )),
    SettingScreen(),
  ];

  int currentScreenIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  navBarController(int cIndex) {
    setState(() {
      currentScreenIndex = cIndex;
    });
  }

  Widget build(BuildContext context) {
    //theme controller instance

    return Scaffold(
      body: _screens[currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentScreenIndex,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedItemColor: Colors.yellow,
          // unselectedItemColor: Colors.black.withOpacity(0.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          onTap: navBarController,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.luggage_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active), label: 'Notification'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
          ]),
    );
  }
}
