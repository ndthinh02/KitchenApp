import 'dart:async';

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

class _BillNotDoneState extends State<BillNotDone> {
  BillController get billController => context.read<BillController>();
  StreamController _streamController = StreamController();
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      loadBill();
    });
    // loadBill();
    _streamController = StreamController();
  }

  loadBill() async {
    billController.loadBillNotDone().then((res) => _streamController.add(res));
  }

  @override
  void dispose() {
    // stop streaming when app close
    _streamController.close();
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
                              Navigator.of(context).push(CreateRoute()
                                  .createAnimationDetailBill(item));
                            },
                            child: ListBillNotDone(
                              billModel: item,
                              index: index,
                              staff: item.staff!,
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
