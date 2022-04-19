import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keranjang_belanja/screens/main_screen.dart';

import 'models/boxes.dart';
import 'models/cart.dart';

void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox<Item>(HiveBoxes.cart);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Buah',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyLoginPage(),
    );
  }
}