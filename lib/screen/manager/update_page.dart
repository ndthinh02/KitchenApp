import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/product_controller.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:image_picker/image_picker.dart';
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
  UploadTask? uploadTask;
  String urlImage = "";
  File? file;
  final _picker = ImagePicker();

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
                      child: buildForm(),
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
                          if (_formKey.currentState!.validate()) {
                            provider.updateProduct(context, widget.id);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14))),
                        child: const Text('Sửa'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Hãy nhập đầy đủ';
                }
                return null;
              },
              controller: provider.nameProductController,
              decoration: const InputDecoration(
                  hintText: 'Tên sản phẩm', labelText: 'Tên sản phẩm'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Hãy nhập đầy đủ';
                }
                return null;
              },
              controller: provider.totalProductController,
              decoration: const InputDecoration(hintText: 'Số lượng sản phẩm'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Hãy nhập đầy đủ';
                }
                return null;
              },
              controller: provider.priceProductController,
              decoration: const InputDecoration(hintText: 'Giá sản phẩm'),
            ),
          ],
        ));
  }
}
