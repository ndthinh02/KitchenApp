import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/bill_controller.dart';
import 'package:flutter_app_kitchen/screen/manager/bill_done.dart';
import 'package:flutter_app_kitchen/screen/manager/bill_not_done.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:provider/provider.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _ManagerProductPageState();
}

class _ManagerProductPageState extends State<BillPage>
    with AutomaticKeepAliveClientMixin<BillPage> {
  BillController get billController => context.read<BillController>();
  BillController get watchController => context.watch<BillController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: [
                Tab(
                  text: "Đơn chưa hoàn thành",
                ),
                Tab(
                  text: "Đơn dã hoàn thành",
                ),
              ]),
              automaticallyImplyLeading: false,
              backgroundColor: colorMain,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Quản lý đơn '),
                ],
              ),
            ),
            backgroundColor: colorScafold,
            body: const TabBarView(children: [
              BillNotDone(),
              BillDone(),
            ])));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
