import 'dart:async';

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

  final StreamController _streamController = StreamController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      loadBill();
    });
  }

  loadBill() async {
    billController.loadBillDone().then((res) => _streamController.add(res));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
    billController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return const Text('Please Wait....');
              } else {
                return Consumer<BillController>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final items = value.listBillModel;
                    if (items == null) {
                      return const Center(child: Text('Kiểm tra lại internet'));
                    }
                    if (items.isEmpty) {
                      return const Center(child: Text('Không có đơn'));
                    }
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CreateRoute()
                                  .createAnimationDetailBill(item));
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
          }
        });
  }
}
