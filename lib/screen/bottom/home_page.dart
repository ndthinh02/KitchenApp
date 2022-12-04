import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/product_controller.dart';
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
  final ScrollController _scrollController = ScrollController();
  int curentItem = 8;
  bool iss = true;
  void _seacrh(String name) {
    setState(() {
      productController.findByName(name);
    });
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    String deviceTokenToSendPushNotification = token.toString();
    RemoteMessage remoteMessage;
    print("Token Value $deviceTokenToSendPushNotification");
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
          print(message.notification!.title);
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

  @override
  Widget build(BuildContext context) {
    // getDeviceTokenToSendNotification();
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
                      4,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber,
                                    image: const DecorationImage(
                                        image: AssetImage('images/cake.jpg'),
                                        fit: BoxFit.cover)),
                                width: 200,
                                height: 70,
                                margin: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    productController
                                        .getProductInStock(context);
                                  },
                                )),
                          )),
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer<ProductController>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final items = provider.mListProduct!;
                        if (items.isEmpty) {
                          return const Text(
                            'Không có sản phẩm',
                            style: TextStyle(color: Colors.black),
                          );
                        }
                        return GridView.builder(
                            controller: _scrollController,
                            itemCount: items.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                          trailing: Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: items[index].total! > 0
                                                    ? Colors.green
                                                    : Colors.red,
                                                size: 14,
                                              ),
                                            ],
                                          ),
                                          title: Text('${items[index].name}'),
                                          backgroundColor: Colors.black,
                                        ),
                                        child: Stack(
                                          children: [
                                            ImageFade(
                                              width: double.infinity,
                                              height: double.infinity,
                                              image: NetworkImage(provider
                                                  .mListProduct![index]
                                                  .urlImage!),
                                              alignment: Alignment.center,
                                              fit: BoxFit.cover,
                                              placeholder: Container(
                                                color: const Color(0xFFCFCDCA),
                                                alignment: Alignment.center,
                                                child: const Icon(Icons.photo,
                                                    color: Colors.white30,
                                                    size: 128.0),
                                              ),

                                              // shows progress while loading an image:
                                              loadingBuilder: (context,
                                                      progress, chunkEvent) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),

                                              // displayed when an error occurs:
                                              errorBuilder: (context, error) =>
                                                  Container(
                                                color: const Color(0xFF6F6D6A),
                                                alignment: Alignment.center,
                                                child: const Icon(Icons.warning,
                                                    color: Colors.black26,
                                                    size: 128.0),
                                              ),
                                            ),
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape
                                                                .circle),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        provider.deleteProduct(
                                                            items[index].sId!,
                                                            index,
                                                            context);
                                                      },
                                                      child: const Icon(
                                                        Icons.clear,
                                                        size: 14,
                                                      ),
                                                    )))
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
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
      if (value == 3) {
        Navigator.of(context)
            .push(CreateRoute().createAnimationAddProductPage());
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
      PopupMenuItem(
        onTap: () {},
        value: 3,
        // row has two child icon and text
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const Text("Thêm sản phẩm")],
        ),
      ),
    ],
    offset: const Offset(0, 70),
    elevation: 2,
  );
}
