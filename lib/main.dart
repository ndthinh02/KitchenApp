import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/add_product_controller.dart';
import 'package:flutter_app_kitchen/controller/bill_controller.dart';
import 'package:flutter_app_kitchen/controller/staff_controller.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/provider/bill/bill_provider.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';
import 'package:flutter_app_kitchen/provider/staff/staff_provider.dart';
import 'package:flutter_app_kitchen/provider/user.dart';
import 'package:provider/provider.dart';

import 'controller/product_controller.dart';

Future<void> main() async {
  // DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const MyApp(), // Wrap your app
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: ((context) =>
            ProductController(productProvider: ProductProvider())),
      ),
      ChangeNotifierProvider(
        create: ((context) => BillController(billProvider: BillProvider())),
      ),
      ChangeNotifierProvider(
        create: ((context) => StaffController(staffProvider: StaffProvider())),
      ),
      ChangeNotifierProvider(
        create: ((context) => BillModel()),
      ),
      ChangeNotifierProvider(
        create: ((context) => BillProvider()),
      ),
      ChangeNotifierProvider(
        create: ((context) =>
            AddProductController(productProvider: ProductProvider())),
      ),
    ],
    child: DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
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
