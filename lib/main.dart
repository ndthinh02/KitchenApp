import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/bill_controller.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';
import 'package:flutter_app_kitchen/screen/my_bottom_nav.dart';
import 'package:flutter_app_kitchen/screen/login_page.dart';
import 'package:provider/provider.dart';

import 'controller/product_controller.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: ((context) =>
            ProductController(productProvider: ProductProvider())),
      ),
      ChangeNotifierProvider(
        create: ((context) =>
            BillController(productProvider: ProductProvider())),
      )
    ],
    child: const MyApp(),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
