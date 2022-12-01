import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/add_product_controller.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:image_picker/image_picker.dart';
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
  UploadTask? uploadTask;
  String urlImage = "";
  File? file;
  final _picker = ImagePicker();
  // Future getImage() async {
  //   String name = DateTime.now().millisecondsSinceEpoch.toString();
  //   Reference reference = FirebaseStorage.instance.ref();
  //   Reference referenceDirImage = reference.child("images");
  //   Reference referenceUploadImage = referenceDirImage.child(name);

  //   final pickedFile =
  //       await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
  //   if (pickedFile != null) {
  //     file = File(pickedFile.path);
  //     setState(() {});
  //     setState(() {
  //       uploadTask = referenceUploadImage.putFile(File(pickedFile.path));
  //     });
  //     print('geehehe${uploadTask?.snapshotEvents}');
  //     final snapshot = await uploadTask!.whenComplete(() {});
  //     urlImage = await snapshot.ref.getDownloadURL();
  //     setState(() {
  //       uploadTask == null;
  //     });
  //   } else {
  //     Fluttertoast.showToast(msg: 'Không có ảnh được chọn');
  //   }
  // }

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
                    // watchProvider.buildProgress()
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  // buildProgress() {
  //   return StreamBuilder(
  //     stream: uploadTask?.snapshotEvents,
  //     builder: (context, snapshot) {
  //       print('ahahahaha${snapshot.data}');
  //       if (snapshot.hasData) {
  //         final data = snapshot.data!;
  //         double progress = data.bytesTransferred / data.totalBytes;
  //         return SizedBox(
  //           height: 50,
  //           child: Stack(
  //             fit: StackFit.expand,
  //             children: [
  //               LinearProgressIndicator(
  //                 value: progress,
  //                 backgroundColor: colorMain,
  //                 color: colorMain,
  //               ),
  //               Center(
  //                 child: Text(
  //                   '${(100 * progress).roundToDouble()}%',
  //                   style: const TextStyle(color: Colors.white),
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       } else {
  //         return const SizedBox(
  //           height: 1,
  //         );
  //       }
  //     },
  //   );
  // }

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
              decoration: const InputDecoration(hintText: 'Tên sản phẩm'),
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
