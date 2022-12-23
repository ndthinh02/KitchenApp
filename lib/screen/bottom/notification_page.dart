import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/provider/notification/notification_provider.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  @override
  void initState() {
    super.initState();
    loadIdStaff();
  }

  loadIdStaff() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idStaff = pref.getString("id")!;
      readNotification.getNotification(idStaff);
    });
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
            child: Consumer<NotificationProvider>(
              builder: (context, data, child) {
                if (data.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final noti = data.mList;
                if (noti!.isEmpty) {
                  return const Center(
                    child: Text("Khong co thong bao"),
                  );
                }
                return ListView.builder(
                    itemCount: data.mList!.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          elevation: 8,
                          child: GestureDetector(
                            onTap: () {},
                            child: ListTile(
                                title: const Text('Thông báo'),
                                leading: const Icon(
                                  Icons.notifications,
                                  color: Colors.amber,
                                ),
                                subtitle: Text(noti[index].content!),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.timer,
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
            )));
  }
}
