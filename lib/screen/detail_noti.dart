import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:image_fade/image_fade.dart';

import '../model/notification.dart';

class DetailNotifi extends StatelessWidget {
  final BillModel bill;
  final Notifications notification;
  const DetailNotifi(
      {super.key, required this.bill, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorMain,
          title: const Text('Thông báo'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tên bàn: ${bill.table!.name}',
                      style: MyTextStyle().textSub,
                    ),
                    Text(
                      '${notification.date}',
                      style: MyTextStyle().textDate,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Tầng số:  ${bill.table!.floor}',
                  style: MyTextStyle().textSub,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Nhân viên phụ trách: ${bill.staff!.name}',
                  style: MyTextStyle().textSub,
                ),
                const SizedBox(
                  height: 20,
                ),
                bill.status == 0
                    ? Text(
                        "Trạng thái đơn: chưa hoàn thành",
                        style: MyTextStyle().textSub,
                      )
                    : Text("Trạng thái đơn: đã hoàn thành",
                        style: MyTextStyle().textSub),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Món ăn trong hóa đơn: ',
                  style: MyTextStyle().textSub,
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bill.foods!.length,
                    itemBuilder: ((context, index) {
                      final items = bill.foods![index];
                      if (bill.foods!.isEmpty) {
                        return const Center(child: Text('Không có đơn!'));
                      }
                      return Card(
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
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
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
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        items.name!,
                                        style: MyTextStyle().textNameBill,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Text(
                                      'Số lượng: ${items.amount}',
                                      style: MyTextStyle().textPriceBill,
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    })),
              ],
            ),
          ),
        ));
  }
}
