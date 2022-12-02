import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../screen/my_bottom_nav.dart';
import '../ui/color.dart';

class AddProductController extends ChangeNotifier {
  final ProductProvider productProvider;
  AddProductController({required this.productProvider});
  final nameProductController = TextEditingController();
  final totalProductController = TextEditingController();
  final priceProductController = TextEditingController();
  late String price = priceProductController.text;
  UploadTask? uploadTask;
  String urlImage = "";
  File? file;
  final _picker = ImagePicker();
  final List<ProductModel> _mListProduct = [];

  ProductModel? _productModel;
  void _clear() {
    nameProductController.clear();
    totalProductController.clear();
    priceProductController.clear();
  }

  Future addProduct(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    _productModel = await productProvider
        .addProduct(nameProductController.text, priceProductController.text,
            totalProductController.text, 1, urlImage)
        .whenComplete(() => _clear())
        .whenComplete(() => Navigator.of(context).pop())
        .whenComplete(() => Fluttertoast.showToast(
            msg: "Thêm thành công", gravity: ToastGravity.TOP))
        .whenComplete(() => file = null)
        .whenComplete(() => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage())));

    print('uhsds$file');
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
      notifyListeners();
      uploadTask = referenceUploadImage.putFile(File(pickedFile.path));
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
      uploadTask = null;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: 'Không có ảnh được chọn', gravity: ToastGravity.TOP);
    }
  }

  buildProgress() {
    return StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        print('ahahahaha${snapshot.data}');
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: colorMain,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
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
