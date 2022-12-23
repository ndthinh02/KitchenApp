import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/provider/create_route.dart';
import 'package:provider/provider.dart';

import '../../controller/bill_controller.dart';
import '../../ui/color.dart';
import '../../ui/text_style.dart';

class SearchBill extends StatefulWidget {
  const SearchBill({super.key});

  @override
  State<SearchBill> createState() => _SearchBillState();
}

class _SearchBillState extends State<SearchBill> {
  BillController get readBillController => context.read<BillController>();
  void seacrh(String text) {
    setState(() {
      readBillController.searchByTable(text);
    });
  }

  @override
  void initState() {
    super.initState();
    readBillController.loadAllBill();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [_buildMenu()],
        backgroundColor: colorMain,
        // title: TextField(
        //   onChanged: (value) => seacrh(value),
        //   decoration: const InputDecoration(
        //       hintText: 'Tên bàn',
        //       border: OutlineInputBorder(borderSide: BorderSide.none)),
        // ),
      ),
      body: Consumer<BillController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final items = controller.listAllBill;
          if (items!.isEmpty) {
            return const Center(
              child: Text("Không có đơn"),
            );
          }
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: ((context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(CreateRoute().createAnimationDetailBill(item));
                    },
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.table!.name!,
                                  style: MyTextStyle().textName,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Image(
                                        image: AssetImage('images/clock.png')),
                                    Text(
                                      item.time!,
                                      style: MyTextStyle().textSub,
                                    ),
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
                                      '\$ ${item.totalPrice}',
                                      style: MyTextStyle().textPrice,
                                    ),
                                  ],
                                ),
                                Text(item.date!)
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
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  onPressed: () {},
                                  child: item.status == 0
                                      ? const Text("Chưa hoàn thành")
                                      : const Text("Đã hoàn thành")),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }));
        },
      ),
    );
  }

  Widget _buildMenu() {
    final BillController billController = Provider.of(context);
    return PopupMenuButton(
      onSelected: ((value) {
        if (value == 1) {
          billController.loadBillFloor1();
        }
        if (value == 2) {
          billController.loadBillFloor2();
        }
        if (value == 3) {
          billController.loadBillFloor3();
        }
        if (value == 4) {
          billController.loadAllBill();
        }
      }),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text('Tầng 1'),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text('Tầng 2'),
        ),
        const PopupMenuItem(
          value: 3,
          child: Text('Tầng 3'),
        ),
        const PopupMenuItem(
          value: 4,
          child: Text('Tất cả đơn'),
        ),
      ],
    );
  }
}
