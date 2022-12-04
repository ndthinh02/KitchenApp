import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/bill_controller.dart';
import 'package:flutter_app_kitchen/item/DetailBill.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:provider/provider.dart';

import '../../provider/create_route.dart';

class ManagerProductPage extends StatefulWidget {
  const ManagerProductPage({super.key});

  @override
  State<ManagerProductPage> createState() => _ManagerProductPageState();
}

class _ManagerProductPageState extends State<ManagerProductPage> {
  BillController get billController => context.read<BillController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    billController.loadBill();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colorMain,
          title: const Text('Quản lý đơn '),
        ),
        backgroundColor: colorScafold,
        body: Consumer<BillController>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final items = value.listBillModel!;
            // ignore: unrelated_type_equality_checks
            // if (items.length + 1 == true) {
            //   Fluttertoast.showToast(msg: 'dnsajdnsjd');
            // }
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
}
