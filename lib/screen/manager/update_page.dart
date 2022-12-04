import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/product_controller.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:provider/provider.dart';

class UpdateProductPage extends StatefulWidget {
  String name;
  num price;
  num total;
  String urlImage;
  String id;
  UpdateProductPage(
      {super.key,
      required this.id,
      required this.name,
      required this.price,
      required this.total,
      required this.urlImage});

  @override
  State<UpdateProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();
  ProductController get provider => context.read<ProductController>();
  ProductController get watchProvider => context.watch<ProductController>();
  late String name = provider.nameProductController.text;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.nameProductController.text = widget.name;
    provider.totalProductController.text = '${widget.total}';
    provider.priceProductController.text = '${widget.price}';

    provider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorMain,
          title: Text(
            'Sửa sản phẩm',
            style: MyTextStyle().textAppbar,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: buildForm(widget.name, widget.total, widget.price),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(onTap: () async {
                      // getImage();
                      provider.showBottom(context);
                    }, child: Consumer<ProductController>(
                      builder: (context, provider, child) {
                        return provider.file == null
                            ? SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(widget.urlImage),
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.file(
                                        File(provider.file!.path).absolute),
                                  ),
                                  const Align(
                                    alignment: Alignment.center,
                                  )
                                ],
                              );
                      },
                    )),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 140,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          provider.updateProduct(
                              context, widget.id, widget.urlImage);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14))),
                        child: const Text('Sửa'),
                      ),
                    ),
                    watchProvider.buildProgress()
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildForm(String name, num total, num price) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                autofocus: false,
                controller: provider.nameProductController,
                decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    hintText: name,
                    labelText: "Tên sản phẩm"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: provider.totalProductController,
                decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    hintText: '$total',
                    labelText: "Số lượng sản phẩm"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: provider.priceProductController,
                decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    hintText: '$price',
                    labelText: "Giá sản phẩm"),
              ),
            ],
          ),
        ));
  }
}
