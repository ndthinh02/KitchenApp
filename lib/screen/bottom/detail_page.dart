import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';
import 'package:flutter_app_kitchen/provider/create_route.dart';
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
        actions: [_builPopupMenu(context)],
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
                        " ${product.price} 000đ",
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
                      : Text('Thể loại: Đồ uống', style: MyTextStyle().textSub),
                  const SizedBox(height: 14),
                  product.total == 0
                      ? Text(
                          'Tình trạng: Hết hàng',
                          style: MyTextStyle().textSub,
                        )
                      : Text('Tình trạng: Còn hàng',
                          style: MyTextStyle().textSub),
                ],
              ))
        ],
      ),
    );
  }

  Widget _builPopupMenu(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (value) async {
        if (value == 1) {
          Navigator.of(context).push(CreateRoute()
              .createAnimationUpdateProductPage(product.name!, product.price!,
                  product.total!, product.urlImage!, product.sId!));
        }
        if (value == 2) {}
        if (value == 3) {}
      },
      itemBuilder: (context) => [
        // popupmenu item 1

        PopupMenuItem(
          value: 1,
          child: Row(
            children: const [Text("Sửa sản phẩm ")],
          ),
        ),
      ],
      offset: const Offset(0, 70),
      elevation: 2,
    );
  }
}
