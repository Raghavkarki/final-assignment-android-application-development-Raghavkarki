// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:async';

import 'package:TheMerchPerch/model/login_model.dart';
import 'package:TheMerchPerch/screen/homepage.dart';
import 'package:TheMerchPerch/screen/login_screen.dart';
import 'package:TheMerchPerch/services/signup_apiservices.dart';
import 'package:TheMerchPerch/utils/shared_preference.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:shake/shake.dart';
import 'package:flutter/foundation.dart' as foundation;

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _currentIndex = 0;
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;
  bool apiCallProcess = false;
  bool hidePassword = true;
  bool rehidePassword = true;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var confirmPass;

  SizedBox _gap() {
    return const SizedBox(
      height: 20,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    listenSensor();
    // Shake Sensor
    ShakeDetector.autoStart(onPhoneShake: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    });
    super.initState();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
      });
      if (_isNear) {
        // Constant.moveToNext(context, const LoginScreen());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 980,
        width: 450,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/icons/bg1.jpg'), fit: BoxFit.cover),
          color: Color.fromARGB(200, 11, 2, 63),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      size: 100,
                      color: Colors.indigo[900],
                    ),
                    _gap(),
                    Text(
                      "Registration",
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _gap(),
                    _gap(),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),

                      keyboardType: TextInputType.emailAddress,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please provide full name";
                        } else {
                          null;
                        }
                      },
                      controller: name,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.indigo.shade900, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        labelText: "Full Name ",
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 58, 6, 247),
                        ),
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.account_circle_outlined,
                          color: Color.fromARGB(255, 58, 6, 247),
                          // color: Colors.black54,
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Email is empty";
                        } else {
                          null;
                        }
                      },
                      controller: email,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.indigo.shade900, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        labelText: "Email",
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 58, 6, 247),
                        ),
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Color.fromARGB(255, 58, 6, 247),
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: password,
                      keyboardType: TextInputType.text,
                      validator: (input) {
                        confirmPass = input;
                        if (input == null || input.isEmpty) {
                          return "Password is required";
                        } else {
                          null;
                        }
                      },
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.indigo.shade900, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        labelText: "Password ",
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 58, 6, 247),
                        ),
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color.fromARGB(255, 58, 6, 247),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo[800],
                          shape: const StadiumBorder(),
                          fixedSize:
                              const Size(double.maxFinite, double.infinity),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (validateAndSave()) {
                            setState(() {
                              apiCallProcess = true;
                            });
                          }
                          signUpCustomer(
                            name.text,
                            email.text,
                            password.text,
                          ).then((value) => {
                                setState(() {
                                  apiCallProcess = false;
                                }),
                                if (value.isAdmin == false)
                                  {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Congratulations ! \n ${value.name} User has been created.\n",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 20.0,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.blue[800],
                                    ),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    ),
                                  }
                                else if (value.message ==
                                    "User validation failed: name: Path `name` is required., email: Path `email` is required.")
                                  {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Error ! \nPlease make sure every thing is correct.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 20.0,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red[800],
                                    )
                                  }
                                else if (value.message == "User already Exists")
                                  {
                                    Fluttertoast.showToast(
                                      msg: "Error ! \nUser already Exists",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 20.0,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red[800],
                                    )
                                  }
                              });
                        },
                        child: apiCallProcess == true
                            ? const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              ),
                      ),
                    ),
                    _gap(),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 254, 255),
                          fontSize: 13,
                        ),
                        children: [
                          const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(fontSize: 15),
                          ),
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                                color: Color.fromARGB(255, 10, 41, 238),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
