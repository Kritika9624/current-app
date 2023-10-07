import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  Future<List?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? gAuth = await gUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        isLoading = false;
      });
      return [credential.accessToken, userCredential];
    } catch (e) {
      print('error in sign in - $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 80),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage("assets/images/logo.png"),
                          height: 32,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Current",
                          style: TextStyle(
                              color: Colors.deepPurpleAccent.shade400,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 56.0),
                      child: Text(
                        "Welcome to Current",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Text(
                        "Login or Signup to find out what's happening",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Image(
                        image: AssetImage("assets/images/login.png"),
                        height: 260,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 56.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                isLoading = true;
                              });
                              List? authDetails = await signInWithGoogle();
                              String? authToken = authDetails?[0];
                              UserCredential creds = authDetails?[1];
                              await prefs.setString(
                                  'authToken', authToken ?? "");
                              await prefs.setString('userName', creds.user!.displayName!);
                              if (authToken != null) {
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => Home(userName: creds.user!.displayName!),),);
                              }
                            },
                            style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurpleAccent.shade400),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                  vertical: 20,
                                ))),
                            child: const Text("Login or Signup"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          isLoading
              ? Dialog(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  child: SpinKitFadingCircle(
                    color: Colors.deepPurpleAccent.shade400,
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}