import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/bill_controller.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:provider/provider.dart';

import '../service/notification.dart';
import '../ui/color.dart';
import '../ui/text_style.dart';

class ListBillNotDone extends StatefulWidget {
  BillModel billModel;
  int index;
  ListBillNotDone({super.key, required this.billModel, required this.index});

  @override
  State<ListBillNotDone> createState() => _DetailBillState();
}

class _DetailBillState extends State<ListBillNotDone> {
  BillModel get readBill => context.read<BillModel>();
  BillModel get watchBill => context.watch<BillModel>();
  BillController get billController => context.read<BillController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.billModel.table!.name.toString(),
                    style: MyTextStyle().textName,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Image(image: AssetImage('images/clock.png')),
                      Text(widget.billModel.time.toString())
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Thành tiền: ',
                        style: MyTextStyle().textSub,
                      ),
                      Text(
                        '\$ ${widget.billModel.totalPrice}',
                        style: MyTextStyle().textPrice,
                      ),
                    ],
                  ),
                  Text(widget.billModel.date.toString())
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: 140,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorMain,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      setState(() {
                        widget.billModel.isToogleDone();
                        if (widget.billModel.isDone) {
                          NotificationKitChen().pushNotification(
                              "Đơn  ${widget.billModel.table!.name} đã xong");
                          billController.updateBill(
                              widget.billModel.sId, 1, context, widget.index);
                        }
                      });
                    },
                    child: !widget.billModel.isDone
                        ? const Text("Chưa hoàn thành")
                        : const Text("Đã hoàn thành")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
