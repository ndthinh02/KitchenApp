import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/bill_controller.dart';
import '../../item/DetailBill.dart';
import '../../provider/create_route.dart';

class BillDone extends StatefulWidget {
  const BillDone({super.key});

  @override
  State<BillDone> createState() => _BillDoneState();
}

class _BillDoneState extends State<BillDone> {
  BillController get billController => context.read<BillController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    billController.loadBillDone();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BillController>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = value.listBillModel!;
        if (items.isEmpty) {
          return const Center(child: Text('Không có đơn'));
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(CreateRoute().createAnimationDetailBill(item));
                },
                child: ListBill(
                  billModel: item,
                  index: index,
                ));
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
