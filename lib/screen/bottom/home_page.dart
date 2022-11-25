import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/product_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/create_route.dart';
import '../../ui/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController get productController => context.read<ProductController>();
  final ScrollController _scrollController = ScrollController();
  int curentItem = 8;
  bool iss = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('object$curentItem');
        if (curentItem < productController.mListProduct!.length) {
          setState(() {
            curentItem += 10;
          });
        }
      }
    });
    productController.loadProductAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quản lý sản phẩm'),
          backgroundColor: colorMain,
          actions: [_builPopupMenu(context)],
        ),
        body: Consumer<ProductController>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final items = provider.mListProduct;
            if (items!.isEmpty) {
              return const Text(
                'Không có sản phẩm',
                style: TextStyle(color: Colors.black),
              );
            }
            return GridView.builder(
                controller: _scrollController,
                itemCount: curentItem,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext context, int index) {
                  if (provider.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CreateRoute()
                          .createAnimationDetailPage(items[index]));
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: GridTile(
                            footer: GridTileBar(
                              trailing: Icon(
                                Icons.radio_button_checked,
                                color: items[index].total! > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              title: Text('${items[index].name}'),
                              backgroundColor: Colors.black,
                            ),
                            child: ImageFade(
                              image: NetworkImage(
                                  provider.mListProduct![index].urlImage!),
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              placeholder: Container(
                                color: const Color(0xFFCFCDCA),
                                alignment: Alignment.center,
                                child: const Icon(Icons.photo,
                                    color: Colors.white30, size: 128.0),
                              ),

                              // shows progress while loading an image:
                              loadingBuilder: (context, progress, chunkEvent) =>
                                  const Center(
                                      child: CircularProgressIndicator()),

                              // displayed when an error occurs:
                              errorBuilder: (context, error) => Container(
                                color: const Color(0xFF6F6D6A),
                                alignment: Alignment.center,
                                child: const Icon(Icons.warning,
                                    color: Colors.black26, size: 128.0),
                              ),
                            ),
                          ),
                        )),
                  );
                });
          },
        ));
  }
}

Widget _builPopupMenu(BuildContext context) {
  final ProductController controller = Provider.of(context);
  return PopupMenuButton<int>(
    onSelected: (value) async {
      if (value == 4) {
        controller.getProductInStock();
      }
      if (value == 1) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        final double? price = pref.getDouble('pirce');
        print('kdmakdnakd$price');
      }
    },
    itemBuilder: (context) => [
      // popupmenu item 1
      PopupMenuItem(
        onTap: () {
          Fluttertoast.showToast(msg: 'Quan ly san mon');
        },
        value: 1,
        // row has two child icon and text.
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const Text("Quản lý món")],
        ),
      ),
      // popupmenu item 2
      PopupMenuItem(
        onTap: () {
          Fluttertoast.showToast(msg: 'Quan ly san pham');
        },
        value: 2,
        // row has two child icon and text
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const Text("Quản lý sản phẩm")],
        ),
      ),
      PopupMenuItem(
        onTap: () {},
        value: 3,
        // row has two child icon and text
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const Text("Quản lý đơn ")],
        ),
      ),
      PopupMenuItem(
        onTap: () {},
        value: 4,
        // row has two child icon and text
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const Text("Sản phẩm còn hàng ")],
        ),
      ),
      PopupMenuItem(
        onTap: () {},
        value: 5,
        // row has two child icon and text
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const Text("Sản phẩm hết hàng")],
        ),
      ),
    ],
    offset: const Offset(0, 70),
    elevation: 2,
  );
}
