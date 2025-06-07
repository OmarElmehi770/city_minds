import 'package:city_minds/presentation/nav_bar_screens/Garage_screen.dart';
import 'package:city_minds/presentation/nav_bar_screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'nav_bar_screens/home_screen.dart';

class BottomNavBarScreens extends StatefulWidget {
   BottomNavBarScreens({super.key});

  @override
  State<BottomNavBarScreens> createState() => _BottomNavBarScreensState();
}

class _BottomNavBarScreensState extends State<BottomNavBarScreens> {
  int currentIndex =0 ;

  List <Widget> screens =[
    GarageScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val){
          currentIndex=val ;
          setState(() {});
          },
        currentIndex: currentIndex,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.garage),label: "Garage"),
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
        ],
      ),
    );
  }
}
