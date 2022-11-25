import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:image_fade/image_fade.dart';

class DetailBill extends StatelessWidget {
  final BillModel bill;
  const DetailBill({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorMain,
          title: const Text('Chi tiết đơn'),
        ),
        body: ListView.builder(
            itemCount: bill.foods!.length,
            itemBuilder: ((context, index) {
              final items = bill.foods![index];
              if (bill.foods!.isEmpty) {
                return const Center(child: Text('Không có đơn!'));
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 140,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: ImageFade(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(items.urlImage!),
                                  loadingBuilder:
                                      (context, progress, chunkEvent) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 38),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items.name!,
                                style: MyTextStyle().textNameBill,
                              ),
                              Text(
                                'Số lượng: ${items.total}',
                                style: MyTextStyle().textPriceBill,
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              );
            })));
  }
}
