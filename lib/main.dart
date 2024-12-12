import 'package:fn_prj/firebase_options.dart';
import 'package:fn_prj/pages/home_page.dart';
import 'package:fn_prj/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fn_prj/pages/see_details_food.dart';

import 'admin/list_Dish1.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DishListPage1()
    );
  }
}
