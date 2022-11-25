import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/bill_controller.dart';
import 'package:flutter_app_kitchen/controller/staff_controller.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';
import 'package:flutter_app_kitchen/provider/staff/staff_provider.dart';
import 'package:flutter_app_kitchen/provider/user.dart';
import 'package:provider/provider.dart';

import 'controller/product_controller.dart';

Future<void> main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: ((context) =>
            ProductController(productProvider: ProductProvider())),
      ),
      ChangeNotifierProvider(
        create: ((context) =>
            BillController(productProvider: ProductProvider())),
      ),
      ChangeNotifierProvider(
        create: ((context) => StaffController(staffProvider: StaffProvider())),
      ),
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
      home: User().checkLogin(),
    );
  }
}
