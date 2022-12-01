import 'package:flutter/cupertino.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';
import 'package:flutter_app_kitchen/screen/manager/add_product_page.dart';
import 'package:flutter_app_kitchen/screen/manager/update_page.dart';
import 'package:flutter_app_kitchen/screen/my_bottom_nav.dart';

import '../screen/bottom/detail_page.dart';
import '../screen/detail_bill.dart';

class CreateRoute {
  Route createAnimationHomePage() {
    return PageRouteBuilder(
      pageBuilder: ((context, animation, secondaryAnimation) =>
          const MyHomePage()),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route createAnimationDetailPage(ProductModel product) {
    return PageRouteBuilder(
      pageBuilder: ((context, animation, secondaryAnimation) => DetailPage(
            product: product,
          )),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route createAnimationDetailBill(BillModel billModel) {
    return PageRouteBuilder(
      pageBuilder: ((context, animation, secondaryAnimation) => DetailBill(
            bill: billModel,
          )),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route createAnimationAddProductPage() {
    return PageRouteBuilder(
      pageBuilder: ((context, animation, secondaryAnimation) =>
          const AddProductPage()),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route createAnimationUpdateProductPage(
      String name, num price, num total, String urlImage, String id) {
    return PageRouteBuilder(
      pageBuilder: ((context, animation, secondaryAnimation) =>
          UpdateProductPage(
            id: id,
            name: name,
            price: price,
            total: total,
            urlImage: urlImage,
          )),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
