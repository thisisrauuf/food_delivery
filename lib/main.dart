import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/screens/order_infos_screen.dart';
import 'package:food_delivery/screens/terbaj.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/providers/cart_provider.dart';
import '/screens/cart_screen.dart';
import '/screens/checkout_screen.dart';
import '/screens/favourite_screen.dart';
import '/screens/food_details_screen.dart';
import '/screens/history_screen.dart';
import '/screens/main_screen.dart';
import '/providers/foods_provider.dart';
import 'providers/orders_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Foods(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => MaterialApp(
          theme: ThemeData(
            fontFamily: 'SF Pro',
            scaffoldBackgroundColor: Color(0xffF2F2F2),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => MainScreen(),
            FoodDetailScreen.routeName: (context) => FoodDetailScreen(),
            FavouriteScreen.routeName: (context) => FavouriteScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            CheckoutScreen.routeName: (context) => CheckoutScreen(),
            HistoryScreen.routeName: (context) => HistoryScreen(),
            OrderInfosScreen.routeName: (context) => OrderInfosScreen(),
          },
        ),
      ),
    );
  }
}