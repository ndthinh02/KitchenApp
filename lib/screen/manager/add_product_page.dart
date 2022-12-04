import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/add_product_controller.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  AddProductController get provider => context.read<AddProductController>();
  AddProductController get watchProvider =>
      context.watch<AddProductController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorMain,
          title: Text(
            'Thêm sản phẩm',
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
                    }, child: Consumer<AddProductController>(
                      builder: (context, provider, child) {
                        return provider.file == null
                            ? const Image(
                                image: AssetImage('images/image_add.png'))
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
                            provider.addProduct(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14))),
                        child: const Text('Thêm'),
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

  Widget buildForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    hintText: "Tên sản phẩm",
                    labelText: "Tên sản phẩm"),
              ),
              const SizedBox(
                height: 20,
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    hintText: 'Số lượng sản phẩm',
                    labelText: "Số lượng sản phẩm"),
              ),
              const SizedBox(
                height: 20,
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    hintText: "Giá sản phẩm",
                    labelText: "Giá sản phẩm"),
              ),
            ],
          ),
        ));
  }
}
