import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/category_controller.dart';
import 'package:flutter_app_kitchen/controller/product_controller.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';

import '../../provider/create_route.dart';
import '../../service/notification_service.dart';
import '../../ui/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController get productController => context.read<ProductController>();
  CategoryController get categoryController =>
      context.read<CategoryController>();
  final ScrollController _scrollController = ScrollController();
  late String title;

  void _seacrh(String name) {
    setState(() {
      productController.findByName(name);
    });
  }

  @override
  void initState() {
    super.initState();
    productController.loadProductAll();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          title = message.notification!.title!;
          print('ansdbhd$title');
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          NotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          NotificationService.createanddisplaynotification(message);
        }
      },
    );
  }

  final double _height = 300;
  int? _destinationIndex;
  void _scrollToIndex(index) {
    _scrollController.animateTo(_height * index,
        duration: const Duration(seconds: 6), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    // getDeviceTokenToSendNotification();
    // productController.getCategory();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: TextField(
            onChanged: (value) => _seacrh(value),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Tìm kiếm sản phẩm"),
          ),
        ),
        backgroundColor: colorMain,
        actions: [
          Row(
            children: [
              const Icon(Icons.search),
              _builPopupMenu(context),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  categoryController.mListCategory.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            switch (index) {
                              case 0:
                                productController.getCategory(context, 1);
                                break;
                              case 1:
                                productController.getCategory(context, 2);
                                break;
                              case 2:
                                productController.getCategory(context, 5);
                                break;
                              case 3:
                                productController.getCategory(context, 4);
                                break;
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber,
                                  image: DecorationImage(
                                      image: categoryController
                                          .mListCategory[index].image,
                                      fit: BoxFit.cover)),
                              width: 200,
                              height: 70,
                              margin: const EdgeInsets.only(right: 10),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: GestureDetector(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // const Icon(Icons.circle,color: ,),
                                          Text(
                                            categoryController
                                                .mListCategory[index].name,
                                            style: MyTextStyle().textCategory,
                                          ),
                                        ],
                                      ),
                                      onTap: () {},
                                    ),
                                  ))),
                        ),
                      )),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Consumer<ProductController>(
                      builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final items = provider.mListProduct;
                    if (items == null) {
                      return const Text(
                        'Kiểm tra lại internet',
                        style: TextStyle(color: Colors.black),
                      );
                    }
                    return ListView.builder(
                        controller: _scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CreateRoute()
                                  .createAnimationDetailPage(items[index]));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                    width: double.infinity,
                                    height: 170,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      elevation: 10,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                        items[index].name!,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: MyTextStyle()
                                                            .textSub,
                                                      )),
                                                  Icon(
                                                    Icons.circle,
                                                    size: 14,
                                                    color:
                                                        items[index].total == 0
                                                            ? Colors.red
                                                            : Colors.green,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  child: ImageFade(
                                                    width: 200,
                                                    height: 150,
                                                    image: NetworkImage(provider
                                                        .mListProduct![index]
                                                        .urlImage!),
                                                    alignment: Alignment.center,
                                                    fit: BoxFit.cover,
                                                    placeholder: Container(
                                                      color: const Color(
                                                          0xFFCFCDCA),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Icon(
                                                          Icons.photo,
                                                          color: Colors.white30,
                                                          size: 128.0),
                                                    ),

                                                    // shows progress while loading an image:

                                                    // displayed when an error occurs:
                                                    errorBuilder:
                                                        (context, error) =>
                                                            Container(
                                                      color: const Color(
                                                          0xFF6F6D6A),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Icon(
                                                          Icons.warning,
                                                          color: Colors.black26,
                                                          size: 128.0),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Giá: ${items[index].price!} 000đ',
                                                    style:
                                                        MyTextStyle().textPrice,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }));
                  })
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorMain,
        onPressed: () async {
          setState(() {
            _destinationIndex = productController.mListProduct!
                .lastIndexOf(productController.mListProduct!.last);
          });
          _scrollToIndex(_destinationIndex);
        },
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}

Widget _builPopupMenu(BuildContext context) {
  final ProductController controller = Provider.of(context);
  return PopupMenuButton<int>(
    onSelected: (value) async {
      if (value == 1) {
        controller.getProductInStock(context);
      }
      if (value == 2) {
        controller.getProductOutOfStock(context);
      }
      // if (value == 3) {
      //   Navigator.of(context)
      //       .push(CreateRoute().createAnimationAddProductPage());
      // }
      if (value == 4) {
        controller.loadProductAll();
      }
    },
    itemBuilder: (context) => [
      // popupmenu item 1

      PopupMenuItem(
        onTap: () {},
        value: 1,
        // row has two child icon and text
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const Text("Sản phẩm còn hàng ")],
        ),
      ),
      PopupMenuItem(
        onTap: () {},
        value: 2,
        // row has two child icon and text
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const Text("Sản phẩm hết hàng")],
        ),
      ),
      // PopupMenuItem(
      //   onTap: () {},
      //   value: 3,
      //   // row has two child icon and text
      //   child: Row(
      //     // ignore: prefer_const_literals_to_create_immutables
      //     children: [const Text("Thêm sản phẩm")],
      //   ),
      // ),
      PopupMenuItem(
        onTap: () {},
        value: 4,
        // row has two child icon and text
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const Text("Tất cả  sản phẩm")],
        ),
      ),
    ],
    offset: const Offset(0, 70),
    elevation: 2,
  );
}
