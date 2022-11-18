import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app_kitchen/controller/product_controller.dart';
import 'package:flutter_app_kitchen/provider/create_route.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';
import 'package:image_fade/image_fade.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController get productController => context.read<ProductController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.loadProductAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ProductController>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(
              child:
                  Lottie.asset('images/loading.json', width: 100, height: 100));
        }
        final items = provider.mListProduct;
        if (items!.isEmpty) {
          return const Text(
            'Không có sản phẩm',
            style: TextStyle(color: Colors.black),
          );
        }
        return GridView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      CreateRoute().createAnimationDetailPage(items[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: ImageFade(
                      image:
                          NetworkImage(provider.mListProduct![index].urlImage!),
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      placeholder: Container(
                        color: const Color(0xFFCFCDCA),
                        alignment: Alignment.center,
                        child: const Icon(Icons.photo,
                            color: Colors.white30, size: 128.0),
                      ),

                      // shows progress while loading an image:
                      loadingBuilder: (context, progress, chunkEvent) => Center(
                          child: Lottie.asset('images/loading.json',
                              width: 100, height: 100)),

                      // displayed when an error occurs:
                      errorBuilder: (context, error) => Container(
                        color: const Color(0xFF6F6D6A),
                        alignment: Alignment.center,
                        child: const Icon(Icons.warning,
                            color: Colors.black26, size: 128.0),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    ));
  }
}
