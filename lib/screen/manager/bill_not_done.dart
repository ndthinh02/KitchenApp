import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/item/bill_not_done.dart';
import 'package:provider/provider.dart';

import '../../controller/bill_controller.dart';
import '../../provider/create_route.dart';

class BillNotDone extends StatefulWidget {
  const BillNotDone({super.key});

  @override
  State<BillNotDone> createState() => _BillNotDoneState();
}

class _BillNotDoneState extends State<BillNotDone>
    with AutomaticKeepAliveClientMixin<BillNotDone> {
  BillController get billController => context.read<BillController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    billController.loadBillNotDone();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BillController>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = value.listBillIsNotDone!;
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
                child: ListBillNotDone(
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
