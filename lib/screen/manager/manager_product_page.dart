import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/bill_controller.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
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
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Card(
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
                                  'Table 1',
                                  style: MyTextStyle().textName,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Image(
                                        image: AssetImage('images/clock.png')),
                                    Text(item.time.toString())
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
                                Text(item.date.toString())
                              ],
                            ),
                            const SizedBox(height: 14),
                            SizedBox(
                              width: 140,
                              height: 45,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: colorMain,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  onPressed: () {},
                                  child: const Text('Edit')),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
