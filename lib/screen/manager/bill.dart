import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/bill_controller.dart';
import 'package:flutter_app_kitchen/item/DetailBill.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:provider/provider.dart';

import '../../provider/create_route.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _ManagerProductPageState();
}

class _ManagerProductPageState extends State<BillPage> {
  BillController get billController => context.read<BillController>();
  BillController get watchController => context.watch<BillController>();

  @override
  void initState() {
    super.initState();
    billController.loadBill();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colorMain,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Quản lý đơn '),
              // watchController.listBillModel!.isEmpty
              //     ? const Text("0")
              //     : Text('Tổng đơn: ${watchController.listBillModel!.length}')
            ],
          ),
          actions: [_buildMenu()],
        ),
        backgroundColor: colorScafold,
        body: Consumer<BillController>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final items = value.listBillModel!;

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
        ));
  }

  Widget _buildMenu() {
    final BillController billController = Provider.of(context);
    return PopupMenuButton(
      onSelected: ((value) {
        if (value == 1) {
          billController.billIsDone(context);
        }
        if (value == 2) {
          billController.billIsNotDone(context);
        }
      }),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text('Đơn đã xong'),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text('Đơn chưa xong'),
        )
      ],
    );
  }
}
