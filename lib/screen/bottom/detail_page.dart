import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:image_fade/image_fade.dart';

import '../../ui/color.dart';

class DetailPage extends StatelessWidget {
  final ProductModel product;
  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
        backgroundColor: colorMain,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageFade(
            image: NetworkImage(
              product.urlImage!,
            ),
            width: double.infinity,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height / 2,
            loadingBuilder: (context, progress, chunkEvent) {
              return const Center(
                child: SizedBox(
                    width: 50, height: 50, child: CircularProgressIndicator()),
              );
            },
          ),
          Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Tên món: ${product.name}',
                          style: MyTextStyle().textName,
                        ),
                      ),
                      Text(
                        "\$ ${product.price}",
                        style: MyTextStyle().textPrice,
                      )
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Số lượng: ${product.total}',
                    style: MyTextStyle().textSub,
                  ),
                  const SizedBox(height: 14),
                  product.type == 1
                      ? Text(
                          'Thể loại: Bánh',
                          style: MyTextStyle().textSub,
                        )
                      : Text('Thể loại: Đồ uống', style: MyTextStyle().textSub)
                ],
              ))
        ],
      ),
    );
  }

  // Widget productType(int index) {
  //   switch (index) {
  //     case 0:
  //   }
  // }
}
