import 'dart:convert';

import 'package:asritha/Constant/API.dart';
import 'package:asritha/Constant/Colors.dart';
import 'package:asritha/Screens/HomePage.dart';
import 'package:asritha/Screens/LoginPage.dart';
import 'package:asritha/Screens/NewUserPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class OTP extends StatefulWidget {
  final String otp;
  final String userID;
  final String mobileNumber;
  OTP({Key key, this.otp, this.mobileNumber, this.userID}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController otpNumber = new TextEditingController();

class _OTPState extends State<OTP> {
  String _code;
  bool _isLoading = false;
  String firebase_id;
  SharedPreferences sharedPreferences;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    getMessage();
    _getData();
  }

  void _getData() async {
    await SmsAutoFill().listenForCode;
  }

  void getMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        // print('onMessage: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        // print('onMessage: $message');
      },
    );

    _firebaseMessaging.getToken().then((token) {
      // print("nandhu");
      // print(token);
      // print(token);
      firebase_id = token;
    });
  }

  firebaseID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'mobile_no': widget.mobileNumber,
      'app_id': firebase_id,
    };

    print(data);
    var jsonResponse;
    var response =
        await http.post(app_api + "/save_app_id", body: jsonEncode(data));
    jsonResponse = json.decode(response.body);
    print(jsonResponse);
  }

  Future<void> _alerBox() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("OTP is not match..."),
            //title: Text(),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, "ok");
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appcolor,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                appcolor,
                appcolor2,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // new Image.asset(
              //   "assets/images/app_logo.png",
              //     height: 220,
              //   width: 220,
              // ),
              // SizedBox(
              //   height: 55,
              // ),
              Text(
                "Verification Code",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please Enter The Verification Code send to  +91 " +
                    widget.mobileNumber,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: white, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 70,
              ),

              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                alignment: Alignment.bottomCenter,
                height: 600,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Enter OTP",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: PinFieldAutoFill(
                          codeLength: 4,
                          //  focusNode: FocusNode(),
                          autoFocus: true,
                          decoration: BoxLooseDecoration(
                              strokeColorBuilder: FixedColorBuilder(
                                Colors.black.withOpacity(0.8),
                              ),
                              //  bgColorBuilder: FixedColorBuilder(Colors.white.withOpacity(0.8)),
                              gapSpace: 25),
                          controller: otpNumber,
                          currentCode: _code,
                          onCodeSubmitted: (val) {
                            print(val);
                          },
                          onCodeChanged: (val) {
                            _code = val;
                            print(val);
                            // if (val.length == 4) {
                            //   FocusScope.of(context).requestFocus(FocusNode());
                            // }
                          },
                        ),
                      ),
                      SizedBox(height: 45),
                      ButtonTheme(
                        buttonColor: appcolor,
                        minWidth: 400,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: appcolor,
                            padding: EdgeInsets.all(13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: appcolor)),
                          ),
                          // color: appcolor,
                          // padding: EdgeInsets.all(13),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //     side: BorderSide(color: appcolor)),
                          onPressed: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            if (widget.otp == otpNumber.text) {
                              if (widget.userID != "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  // _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  backgroundColor: appcolor,
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircularProgressIndicator(),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Please Wait'),
                                    ],
                                  ),
                                ));
                                firebaseID();
                                sharedPreferences.setString(
                                    "user_id", widget.userID);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewUserPage(
                                            mobilenum: widget.mobileNumber,
                                          )),
                                );
                              }
                            } else {
                              _alerBox();
                            }
                            //   Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => NewUserPage()),
                            // );
                          },
                          child: Text(
                            "VERIFY",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
                        },
                        child: Text(
                          "Resend OTP",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      // Text("Did't get the code? Resend", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
