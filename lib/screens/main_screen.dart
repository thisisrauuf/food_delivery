import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/providers/foods_provider.dart';
import 'package:food_delivery/providers/profile_provider.dart';
import 'package:food_delivery/screens/favourite_screen.dart';
import 'package:food_delivery/screens/history_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/my_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero)
        .then((_) => {
              Provider.of<Foods>(context, listen: false).fetchData(),
            })
        .then((value) => {
              Provider.of<ProfileInfos>(context, listen: false)
                  .fetchProfileData(),
            });
    super.initState();
  }

  int _currentIndex = 0;

  final _currentTab = [
    HomeScreen(),
    FavouriteScreen(),
    MyProfileScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentTab[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: kOrangeColor,
        unselectedItemColor: kIconButtonColor,
        elevation: 0,
        iconSize: 31.w,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          )
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
