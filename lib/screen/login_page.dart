import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/staff_controller.dart';
import 'package:flutter_app_kitchen/provider/create_route.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  final TextEditingController textUserNameController = TextEditingController();
  final TextEditingController textPasstroller = TextEditingController();
  StaffController get readStaff => context.read<StaffController>();
  bool isShowPass = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(readStaff.loadStaff());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage('images/unsplash.png')),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Text(
              'Login',
              style: MyTextStyle().textLogin,
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  TextFormField(
                      style: MyTextStyle().textUsername,
                      controller: textUserNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          fillColor: Colors.black.withOpacity(0.8),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: "Tài khoản",
                          hintStyle: MyTextStyle().textUsername,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40)))),
                  const SizedBox(height: 30),
                  TextFormField(
                      style: MyTextStyle().textUsername,
                      obscureText: isShowPass,
                      controller: textPasstroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isShowPass = !isShowPass;
                              });
                            },
                            icon: Icon(
                              isShowPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                          fillColor: Colors.black.withOpacity(0.8),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: "Mật khẩu",
                          hintStyle: MyTextStyle().textUsername,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40)))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Liên hệ với quản lý',
                    style: MyTextStyle().textManager,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Consumer<StaffController>(builder: ((context, provider, child) {
              return SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          backgroundColor: Colors.white,
                          elevation: 5),
                      onPressed: () async {
                        if (textPasstroller.text.isEmpty ||
                            textUserNameController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Bạn cần nhập đầy đủ");
                        } else if (textUserNameController.text ==
                                provider.nameStaff &&
                            textPasstroller.text ==
                                provider.mListStaff![0].password) {
                          Fluttertoast.showToast(msg: "Đăng nhập thành công");
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString("name", provider.mListStaff![0].name!);

                          Navigator.of(context).pushReplacement(
                              CreateRoute().createAnimationHomePage());
                        } else {
                          Fluttertoast.showToast(
                              msg: "Sai tên tài khoản hoặc mật khẩu");
                        }
                      },
                      child: Text(
                        'Login',
                        style: MyTextStyle().textUsername,
                      )));
            }))
          ],
        ),
      ),
    ));
  }
}
