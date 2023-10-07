import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoading = true;
  bool authTokenExists = false;
  String? userName;
  var onLoad;

  @override
  void initState() {
    super.initState();
    onLoad = initData();
  }

  Future<void> initData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Future.delayed(const Duration(milliseconds: 2500), () async {
      String? authToken = prefs.getString('authToken');
      setState(() {
        isLoading = false;
        userName = prefs.getString('userName');
        if (authToken != '') {
          authTokenExists = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: onLoad,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return isLoading
              ? Container(
                  color: Colors.deepPurpleAccent.shade400,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("assets/images/logo_white.png"),
                            height: 45,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Current",
                            style: TextStyle(color: Colors.white, fontSize: 32),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : authTokenExists
                  ? Home(
                      userName: userName ?? "",
                    )
                  : const Login();
        } else {
          return const Align(
              alignment: Alignment.center,
              child: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ));
        }
      },
    ));
  }
}