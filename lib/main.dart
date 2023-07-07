import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes/src/helper/hive/hive_utils.dart';
import 'package:personal_notes/src/my_app.dart';

void main() async {
  await HiveUtils.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
