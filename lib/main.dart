import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/network/remote/dio_helper.dart';
import 'package:food_delivery/shared/styles/colors.dart';
import 'package:food_delivery/layouts/home_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.grey[700],
            labelColor: backgroundColor,
            indicatorColor: Colors.teal,
            dividerColor: Colors.transparent),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: backgroundColor
        )
      ),
      home: HomeLayout(),
    );
  }
}
