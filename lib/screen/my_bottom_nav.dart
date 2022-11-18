import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/screen/home_page.dart';
import 'package:flutter_app_kitchen/screen/manager/manager_product_page.dart';
import 'package:flutter_app_kitchen/screen/notification_page.dart';
import 'package:flutter_app_kitchen/screen/profile.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
  final List<Widget> _widgetOption = [
    const HomePage(),
    const NotificationPage(),
    const ManagerProductPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorMain,
          actions: [_builPopupMenu()],
        ),
        bottomNavigationBar: BottomAppBar(
          color: colorBottomAppbar,
          shape: const CircularNotchedRectangle(),
          child: _buildMyNavBar(context),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: colorMain,
            onPressed: () {},
            child: const Image(
              image: AssetImage('images/float_btn.png'),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _widgetOption.elementAt(pageIndex));
  }

  Container _buildMyNavBar(BuildContext context) {
    return Container(
        height: 70,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              const GButton(
                backgroundColor: Colors.transparent,
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              const GButton(
                backgroundColor: Colors.transparent,
                iconColor: Colors.amber,
                icon: Icons.notifications,
                iconActiveColor: Colors.amber,
                text: 'Thông băos',
              ),
              const GButton(
                backgroundColor: Colors.transparent,
                icon: Icons.home_outlined,
                text: 'Quản lý đơn',
              ),
              const GButton(
                backgroundColor: Colors.transparent,
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

  Widget _builPopupMenu() {
    return PopupMenuButton<int>(
      onSelected: (value) {
        if (value == 3) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const ManagerProductPage())));
        }
      },
      itemBuilder: (context) => [
        // popupmenu item 1
        PopupMenuItem(
          onTap: () {
            Fluttertoast.showToast(msg: 'Quan ly san mon');
          },
          value: 1,
          // row has two child icon and text.
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [Text("Quản lý món")],
          ),
        ),
        // popupmenu item 2
        PopupMenuItem(
          onTap: () {
            Fluttertoast.showToast(msg: 'Quan ly san pham');
          },
          value: 2,
          // row has two child icon and text
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [const Text("Quản lý sản phẩm")],
          ),
        ),
        PopupMenuItem(
          onTap: () {},
          value: 3,
          // row has two child icon and text
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [const Text("Quản lý đơn ")],
          ),
        ),
      ],
      offset: const Offset(0, 70),
      elevation: 2,
    );
  }
}
