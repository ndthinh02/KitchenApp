import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';
import 'package:flutter_app_kitchen/ui/dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../screen/my_bottom_nav.dart';
import '../ui/color.dart';

class ProductController extends ChangeNotifier {
  final ProductProvider? productProvider;
  ProductController({required this.productProvider});
  bool isLoading = true;
  List<ProductModel>? mListProduct;
  late List<ProductModel>? listFilterProduct = mListProduct;

  ProductModel? _productModel;
  final nameProductController = TextEditingController();
  final totalProductController = TextEditingController();
  final priceProductController = TextEditingController();
  UploadTask? uploadTask;
  String imageUrl = "";
  double? progess;
  File? file;
  final _picker = ImagePicker();
  void _clear() {
    nameProductController.clear();
    totalProductController.clear();
    priceProductController.clear();
  }

  Future loadProductAll() async {
    isLoading = true;
    mListProduct = listFilterProduct = await productProvider?.getProduct();
    isLoading = false;
    notifyListeners();
  }

  Future deleteProduct(String id, int index, BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: 'Thông báo',
            description: 'Bạn có muốn xóa sản phẩm này không ?',
            actionYes: () async {
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
                      msg: "Xóa thành công", gravity: ToastGravity.TOP));
              notifyListeners();
            },
            actionNo: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  Future getImage(BuildContext context) async {
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImage = reference.child("images");
    Reference referenceUploadImage = referenceDirImage.child(name);

    final pickedFile = await _picker
        .pickImage(source: ImageSource.gallery, imageQuality: 80)
        .whenComplete(() => progess = 0);
    file = File(pickedFile!.path);
    notifyListeners();
    uploadTask = referenceUploadImage.putFile(File(pickedFile.path));
    final snapshot = await uploadTask!.whenComplete(() {});
    imageUrl = await snapshot.ref.getDownloadURL();
    uploadTask = null;
    if (pickedFile != null) {
    } else {
      Fluttertoast.showToast(
          msg: 'Không có ảnh được chọn', gravity: ToastGravity.TOP);
    }
    notifyListeners();
  }

  Future getCamera(BuildContext context) async {
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImage = reference.child("images");
    Reference referenceUploadImage = referenceDirImage.child(name);

    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    file = File(pickedFile!.path);
    notifyListeners();
    uploadTask = referenceUploadImage.putFile(File(pickedFile.path));
    final snapshot = await uploadTask!.whenComplete(() {});
    imageUrl = await snapshot.ref.getDownloadURL();
    uploadTask = null;
    if (pickedFile != null) {
    } else {
      Fluttertoast.showToast(
          msg: 'Không có ảnh được chọn', gravity: ToastGravity.TOP);
    }
    notifyListeners();
  }

  Future updateProduct(BuildContext context, String id, String url) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    if (file == null) {
      _productModel = await productProvider
          ?.updateProduct(id, nameProductController.text,
              priceProductController.text, totalProductController.text, url)
          .whenComplete(() => Navigator.of(context).pop())
          .whenComplete(() => _clear())
          .whenComplete(() => file = null)
          .whenComplete(() => Fluttertoast.showToast(
              msg: "Sửa thành công", gravity: ToastGravity.TOP))
          .whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MyHomePage())));
      notifyListeners();
    } else {
      if (progess! <= 0) {
        return;
      } else {
        if (imageUrl.isEmpty) {
          Fluttertoast.showToast(
              msg: 'Đã xảy ra lỗi, hãy chọn lại ảnh',
              gravity: ToastGravity.TOP);
        } else {
          _productModel = await productProvider
              ?.updateProduct(
                  id,
                  nameProductController.text,
                  priceProductController.text,
                  totalProductController.text,
                  imageUrl)
              .whenComplete(() => Navigator.of(context).pop())
              .whenComplete(() => _clear())
              .whenComplete(() => file = null)
              .whenComplete(() => Fluttertoast.showToast(
                  msg: "Sửa thành công", gravity: ToastGravity.TOP))
              .whenComplete(() => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MyHomePage())));

          notifyListeners();
        }
      }
    }
  }

  getProductInStock(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
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
      barrierDismissible: false,
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

  findByName(String seacrh) {
    // rong
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

  buildProgress() {
    return StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        print('ahahahaha${snapshot.data}');
        if (snapshot.hasData) {
          final data = snapshot.data!;
          progess = data.bytesTransferred / data.totalBytes;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progess,
                    backgroundColor: Colors.grey,
                    color: colorMain,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progess!).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const SizedBox(
            height: 1,
          );
        }
      },
    );
  }

  getCategory(BuildContext context, int category) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    mListProduct = await productProvider!
        .getProductByCategory(category)
        .whenComplete(() => Navigator.of(context).pop());
    print('sadsd ${mListProduct!.length}');
    notifyListeners();
  }
}
