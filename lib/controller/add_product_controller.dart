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
  String urlImageeee = "";
  double? progres;

  File? file;
  final _picker = ImagePicker();

  ProductModel? _productModel;
  void _clear() {
    nameProductController.clear();
    totalProductController.clear();
    priceProductController.clear();
  }

  Future getImage(BuildContext context) async {
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImage = reference.child("images");
    Reference referenceUploadImage = referenceDirImage.child(name);

    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    file = File(pickedFile!.path);
    notifyListeners();
    uploadTask = referenceUploadImage.putFile(File(pickedFile.path));
    final snapshot = await uploadTask!.whenComplete(() {});
    urlImageeee = await snapshot.ref.getDownloadURL();
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

    final pickedFile = await _picker
        .pickImage(source: ImageSource.camera, imageQuality: 80)
        .whenComplete(() => progres = 0);

    file = File(pickedFile!.path);
    notifyListeners();
    uploadTask = referenceUploadImage.putFile(File(pickedFile.path));
    final snapshot = await uploadTask!.whenComplete(() {});
    urlImageeee = await snapshot.ref.getDownloadURL();

    uploadTask = null;
    if (pickedFile != null) {
    } else {
      Fluttertoast.showToast(
          msg: 'Không có ảnh được chọn', gravity: ToastGravity.TOP);
      file = null;
    }
    notifyListeners();
  }

  Future addProduct(BuildContext context, int type) async {
    if (progres! <= 0) {
      return;
    } else {
      print("heeh lon hon ne");
      if (urlImageeee.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Đã xảy ra lỗi, hãy chọn lại ảnh', gravity: ToastGravity.TOP);
      } else {
        if (file == null) {
          Fluttertoast.showToast(
              msg: "Hãy chọn ảnh", gravity: ToastGravity.TOP);
        } else {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
          _productModel = await productProvider
              .addProduct(
                  nameProductController.text,
                  priceProductController.text,
                  totalProductController.text,
                  type,
                  urlImageeee)
              .whenComplete(() => _clear())
              .whenComplete(() => Navigator.of(context).pop())
              .whenComplete(() => Fluttertoast.showToast(
                  msg: "Thêm thành công", gravity: ToastGravity.TOP))
              .whenComplete(() => file = null)
              .whenComplete(() => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MyHomePage())));

          notifyListeners();
        }
      }
    }
  }

  buildProgress() {
    return StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          progres = data.bytesTransferred / data.totalBytes;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progres,
                    backgroundColor: Colors.grey,
                    color: colorMain,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progres!).roundToDouble()}%',
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
