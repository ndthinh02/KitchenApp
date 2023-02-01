import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/screen/manager/bill.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/notification/notification_provider.dart';
import 'bottom/home_page.dart';
import 'bottom/notification_page.dart';
import 'bottom/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textUserNameController = TextEditingController();
  final TextEditingController textPasstroller = TextEditingController();
  bool isShowPass = true;
  int pageIndex = 0;
  String idStaff = "";
  NotificationProvider get readNotification =>
      context.read<NotificationProvider>();
  NotificationProvider get watch => context.watch<NotificationProvider>();

  final List<Widget> _widgetOption = [
    const HomePage(),
    const NotificationPage(),
    const BillPage(),
    const ProfilePage(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadIdStaff();
  }

  loadIdStaff() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idStaff = pref.getString("id")!;
    readNotification.getNotification(idStaff);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _buildMyNavBar(context),
        body: _widgetOption.elementAt(pageIndex));
  }

  Container _buildMyNavBar(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: colorMain),
        height: 70,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              const GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                onPressed: () {
                  readNotification.initNoti();
                },
                leading: Stack(
                  children: [
                    const Icon(Icons.notifications_outlined),
                    Positioned(
                        child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 8,
                      child: readNotification.isToogle
                          ? Text(watch.mList!.length.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 7))
                          : const Text('0',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 7)),
                    ))
                  ],
                ),
                icon: Icons.notifications_outlined,
                text: 'Thông báo',
              ),
              const GButton(
                icon: Icons.today_outlined,
                text: 'Quản lý đơn',
              ),
              const GButton(
                icon: (Icons.person_outline_outlined),
                text: 'Cá nhân',
              ),
            ],
            selectedIndex: pageIndex,
            onTabChange: (index) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
        )));
  }
}
