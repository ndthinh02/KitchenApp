import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../screen/my_bottom_nav.dart';

class ProductController extends ChangeNotifier {
  final ProductProvider? productProvider;
  ProductController({required this.productProvider});
  bool isLoading = true;
  List<ProductModel>? mListProduct;
  List<ProductModel>? listFilterProduct;

  ProductModel? _productModel;
  final nameProductController = TextEditingController();
  final totalProductController = TextEditingController();
  final priceProductController = TextEditingController();
  UploadTask? uploadTask;
  String urlImage = "";
  File? file;
  final _picker = ImagePicker();
  void _clear() {
    nameProductController.clear();
    totalProductController.clear();
    priceProductController.clear();
  }

  Future loadProductAll() async {
    listFilterProduct = mListProduct;
    isLoading = true;
    mListProduct = await productProvider?.getProduct();
    isLoading = false;
    notifyListeners();
  }

  Future deleteProduct(String id, int index, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: const Text("Bạn có muốn xóa sản phẩm này không ?"),
            actions: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Không")),
                  TextButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        await productProvider
                            ?.deleteProduct(id)
                            .whenComplete(() => Navigator.of(context).pop())
                            .whenComplete(() => Navigator.of(context).pop())
                            .whenComplete(() => mListProduct?.removeAt(index))
                            .whenComplete(() => Fluttertoast.showToast(
                                msg: "Xóa thành công",
                                gravity: ToastGravity.TOP));
                        notifyListeners();
                      },
                      child: const Text("Có")),
                ],
              )
            ],
          );
        });
  }

  Future updateProduct(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    _productModel = await productProvider
        ?.updateProduct(id, nameProductController.text,
            priceProductController.text, totalProductController.text, urlImage)!
        .whenComplete(() => Navigator.of(context).pop())
        .whenComplete(() => _clear())
        .whenComplete(() => Fluttertoast.showToast(
            msg: "Sửa thành công", gravity: ToastGravity.TOP))
        .whenComplete(() => file = null)
        .whenComplete(() => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage())));
  }

  getProductInStock(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    mListProduct = await productProvider!
        .getProductInStock()
        .whenComplete(() => Navigator.of(context).pop());

    notifyListeners();
  }

  getProductOutOfStock(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    mListProduct = await productProvider!
        .getProdcutOutOfStock()
        .whenComplete(() => Navigator.of(context).pop());
    notifyListeners();
  }

  Future getImage(BuildContext context) async {
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImage = reference.child("images");
    Reference referenceUploadImage = referenceDirImage.child(name);

    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      file = File(pickedFile.path);
      uploadTask = referenceUploadImage.putFile(File(pickedFile.path));
      notifyListeners();
      final snapshot = await uploadTask!.whenComplete(() {});
      urlImage = await snapshot.ref.getDownloadURL();
      uploadTask = null;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: 'Không có ảnh được chọn', gravity: ToastGravity.TOP);
    }
  }

  Future getCamera(BuildContext context) async {
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImage = reference.child("images");
    Reference referenceUploadImage = referenceDirImage.child(name);

    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedFile != null) {
      file = File(pickedFile.path);
      notifyListeners();
      uploadTask = referenceUploadImage.putFile(File(pickedFile.path));
      final snapshot = await uploadTask!.whenComplete(() {});
      urlImage = await snapshot.ref.getDownloadURL();

      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: 'Không có ảnh được chọn', gravity: ToastGravity.TOP);
    }
  }

  findByName(String seacrh) {
    if (seacrh.isEmpty) {
      mListProduct = listFilterProduct;
      notifyListeners();
    } else {
      mListProduct = listFilterProduct!
          .where((element) =>
              element.name!.toLowerCase().contains(seacrh.toLowerCase()))
          .toList();
      print('sadnsjd${mListProduct!.length}');
      notifyListeners();
    }
  }

  showBottom(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 140,
          child: Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    onTap: () {
                      getImage(context);
                      Navigator.of(context).pop();
                    },
                    leading: const Icon(Icons.image),
                    title: const Text("Thư Viện"),
                  ),
                  ListTile(
                    onTap: () {
                      getCamera(context);
                      Navigator.of(context).pop();
                    },
                    leading: const Icon(Icons.camera),
                    title: const Text("Camera"),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
