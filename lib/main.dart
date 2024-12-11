import 'package:firebase_core/firebase_core.dart';
import 'package:fn_prj/admin/add_Dish.dart';
import 'package:fn_prj/admin/add_Dish1.dart';
import 'package:fn_prj/admin/admin_login_page.dart';
import 'package:fn_prj/firebase_options.dart';
import 'package:fn_prj/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AddDish1(),
  ));
}
