import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app_kitchen/controller/bill_controller.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(body: Consumer<BillController>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const CircularProgressIndicator();
        }
        final items = value.listBillModel!;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              child: Column(
                children: [Text(item.idTable.toString())],
              ),
            );
          },
        );
      },
    ));
  }
}
