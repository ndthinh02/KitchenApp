import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/bill_controller.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/provider/notification/notification_provider.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/bill/bill_provider.dart';
import '../../provider/create_route.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationProvider get readNotification =>
      context.read<NotificationProvider>();
  String idStaff = "";
  String idBill = "";
  BillController get watchBill => context.watch<BillController>();
  BillModel? billModel;
  StreamController _streamController = StreamController();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      loadIdStaff();
    });
    _streamController = StreamController();
  }

  loadIdStaff() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idStaff = pref.getString("id")!;
    print('hehe$idStaff');
    readNotification
        .getNotification(idStaff)
        .then((res) => _streamController.add(res));
  }

  @override
  void dispose() {
    // stop streaming when app close
    _streamController.close();
    readNotification.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Thông báo"),
          backgroundColor: colorMain,
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: StreamBuilder(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                return Consumer<NotificationProvider>(
                  builder: (context, data, child) {
                    if (data.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final noti = data.mList;
                    if (noti == null) {
                      return const Center(
                        child: Text("Kiểm tra lại internet"),
                      );
                    }
                    if (noti.isEmpty) {
                      return const Center(
                        child: Text("Không có thông báo"),
                      );
                    }
                    return ListView.builder(
                        itemCount: data.mList!.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                );
                                billModel = await BillProvider()
                                    .getBillById(noti[index].idBill!)
                                    .whenComplete(
                                        () => Navigator.of(context).pop());

                                Navigator.of(context).push(CreateRoute()
                                    .createAnimationDetailNotifi(
                                        billModel!, noti[index]));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                elevation: 8,
                                child: ListTile(
                                    title: Text(noti[index].title!),
                                    leading: const CircleAvatar(
                                      child: Icon(
                                        Icons.notifications,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    subtitle: Text(noti[index].content!),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.timer,
                                          size: 15,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          noti[index].time!,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          );
                        }));
                  },
                );
              },
            )));
  }
}
