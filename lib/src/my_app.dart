import 'package:flutter/material.dart';
// import 'package:personal_notes/src/counter_page.dart';
import 'package:personal_notes/src/helper/hive/hive_keys.dart';
import 'package:personal_notes/src/helper/hive/hive_utils.dart';
import 'package:personal_notes/src/home_page.dart';
import 'package:personal_notes/src/login_page.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final userID = HiveUtils.isContainKey(HiveKeys.userId)
      ? HiveUtils.get(HiveKeys.userId)
      : null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: userID == null || userID.toString() == ""
          ? const LoginPage()
          : const HomePage(),
    );
  }
}
