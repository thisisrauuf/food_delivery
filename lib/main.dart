import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/providers/auth.dart';
import 'package:food_delivery/screens/login_screen.dart';
import 'package:food_delivery/screens/order_infos_screen.dart';
import 'package:food_delivery/screens/search_screen.dart';
import 'package:food_delivery/screens/splash_screen.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        // ChangeNotifierProxyProvider<Auth, Foods>(
        //   create: (_) => Foods('', '', []),
        //   update: (_, auth, previousFoods) =>
        //       Foods(auth.token, auth.userID, previousFoods!.foods),
        // ),
        ChangeNotifierProvider(
          create: (context) => Foods(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Foods, Orders>(
          create: (_) => Orders([], []),
          update: (_, foods, previousOrders) =>
              Orders(foods.foods, previousOrders!.orders),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => Orders(),
        // ),
      ],
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => MaterialApp(
          theme: ThemeData(
            fontFamily: 'SF Pro',
            scaffoldBackgroundColor: Color(0xffF2F2F2),
          ),
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }
              if (userSnapshot.hasData) {
                return MainScreen();
              }
              return LogInScreen();
            },
          ),
          routes: {
            // '/': (context) => auth.isAuth ? MainScreen() : LogInScreen(),
            // '/': (context) => MainScreen(),
            MainScreen.routeName: (context) => MainScreen(),
            FoodDetailScreen.routeName: (context) => FoodDetailScreen(),
            FavouriteScreen.routeName: (context) => FavouriteScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            CheckoutScreen.routeName: (context) => CheckoutScreen(),
            HistoryScreen.routeName: (context) => HistoryScreen(),
            OrderInfosScreen.routeName: (context) => OrderInfosScreen(),
            SearchScreen.routName: (context) => SearchScreen(),
          },
        ),
      ),
    );
  }
}
