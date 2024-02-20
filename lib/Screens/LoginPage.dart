import 'package:asritha/Constant/API.dart';
import 'package:asritha/Constant/Colors.dart';
import 'package:asritha/Screens/HomePage.dart';
import 'package:asritha/Screens/NewUserPage.dart';
import 'package:asritha/Screens/OTP.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController mobileNumber = new TextEditingController();

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  String userID;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
  }

  login(
    mobilenumber,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'mobile_no': mobilenumber,
    };

    print(data);

    var jsonResponse;
    var response =
        await http.post(app_api + "/send_otp", body: jsonEncode(data));
    // var response = await http.post(app_api + "/about_us");
    jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse['data']['user_id'].toString());
      userID = jsonResponse['data']['user_id'].toString();
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        print('-------1----');
        print(userID);
        if (userID != '') {
          firebaseID();
          sharedPreferences.setString("user_id", userID);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              // builder: (BuildContext context) =>
              builder: (BuildContext context) => HomePage()

              // OTP(
              //   mobileNumber: mobileNumber.text,
              //   otp: jsonResponse['data']['otp'].toString(),
              //   userID: jsonResponse['data']['user_id'].toString(),
              // )
              ));
          // _alerDialog(jsonResponse['message']);
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NewUserPage(mobilenum: mobileNumber.toString())));
        }
      }
    } else {
      jsonResponse = json.decode(response.body);
      _alerDialog(jsonResponse['message']);
      setState(() {
        _isLoading = false;
      });
    }
  }

  String firebase_id;

  firebaseID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'mobile_no': mobileNumber,
      'app_id': firebase_id,
    };
  }
// final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// final TextEditingController mobileNumber = new TextEditingController();

// class _LoginPageState extends State<LoginPage> {
//   bool _isLoading = false;
//   SharedPreferences sharedPreferences;

//   @override
//   void initState() {
//     super.initState();
//   }

  // firebaseID() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Map data = {
  //     'mobile_no': mobileNumber,
  //     'app_id': firebase_id,
  //   };

//     login(
//       mobilenumber,
//     ) async {
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       Map data = {
//         'mobile_no': mobilenumber,
//       };

//       print(data);

//       var jsonResponse;
//       var response =
//           await http.post(app_api + "/send_otp", body: jsonEncode(data));
//       // var response = await http.post(app_api + "/about_us");
//       jsonResponse = json.decode(response.body);
//       print(jsonResponse);

//       if (response.statusCode == 200) {
//         jsonResponse = json.decode(response.body);
//         if (jsonResponse != null) {
//           setState(() {
//             _isLoading = false;
//           });
//           userID:
//           jsonResponse['data']['user_id'].toString();
//           if (userID != "") {
//             firebaseID();

//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           } else {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => NewUserPage(
//                         mobilenum: mobileNumber.toString(),
//                       )),
//             );
//           }
//         }
//         // Navigator.of(context).pushReplacement(MaterialPageRoute(
//         //     builder: (BuildContext context) =>
//         //         // builder: (BuildContext context) => HomePage(),

//         //         OTP(
//         //           mobileNumber: mobileNumber.text,
//         //           otp: jsonResponse['data']['otp'].toString(),
//         //           userID: jsonResponse['data']['user_id'].toString(),
//         //         )));
//         // _alerDialog(jsonResponse['message']);
//       // } else {
//       //   jsonResponse = json.decode(response.body);
//       //   // _alerDialog(jsonResponse['message']);
//       //   setState(() {
//       //     _isLoading = false;
//       //   });
//       // }
//     }
//   }

  Future<void> _alerDialog(message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
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

  Future<void> _alerBox() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Please Enter Mobile Number"),
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
              new Image.asset(
                "assets/images/app_logo.png",
                height: 220,
                width: 220,
              ),
              SizedBox(
                height: 55,
              ),
              Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: white),
              ),
              SizedBox(
                height: 10,
              ),
              // Text("via Mobile Number", style: TextStyle(fontSize: 18, color: white,fontWeight: FontWeight.w500),),
              SizedBox(
                height: 45,
              ),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                alignment: Alignment.bottomCenter,
                height: 300,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mobile Number",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter number';
                          }
                          return null;
                        },
                        onSaved: (String value) {},
                        controller: mobileNumber,
                        obscureText: false,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: black,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.send_to_mobile),
                          fillColor: white,
                          filled: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          hintText: ('Enter Mobile Number'),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: appcolor, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: new OutlineInputBorder(
                            borderSide: BorderSide(color: appcolor, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: appcolor, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: appcolor, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: appcolor, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      ButtonTheme(
                        buttonColor: appcolor,
                        // minWidth: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appcolor,
                            padding: EdgeInsets.all(13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: appcolor)),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          // style: ElevatedButton.styleFrom(
                          //   shape: RoundedRectangleBorder(
                          //       side: const BorderSide(
                          //         width: 2,
                          //         color: appcolor,
                          //       ),
                          //       borderRadius: BorderRadius.circular(10)),
                          //   backgroundColor: appcolor,
                          //   minimumSize: const Size.fromHeight(50),
                          // ),
                          onPressed: () async {
                            if (mobileNumber.text.isEmpty) {
                              _alerBox();
                            } else {
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
                              login(
                                mobileNumber.text,
                              );
                              final signcode =
                                  await SmsAutoFill().getAppSignature;
                            }

                            // Navigator.of(context).pushReplacement(MaterialPageRoute(
                            //  builder: (BuildContext context) => HomaePage(
                            // )));
                          },
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: white),
                          ),
                        ),
                        // ElevatedButton(
                        //   style: TextButton.styleFrom(
                        //     backgroundColor: appcolor,
                        //     padding: EdgeInsets.all(13),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         side: BorderSide(color: appcolor)),
                        //     minimumSize: const Size.fromHeight(50),
                        //   ),
                        //   // color: appcolor,
                        //   // padding: EdgeInsets.all(13),
                        //   // shape: RoundedRectangleBorder(
                        //   // borderRadius: BorderRadius.circular(10.0),
                        //   // side: BorderSide(color: appcolor)
                        //   // ),
                        //   onPressed: () async {
                        //     if (mobileNumber.text.isEmpty) {
                        //       _alerBox();
                        //     } else {
                        //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //         // _scaffoldKey.currentState.showSnackBar(SnackBar(
                        //         backgroundColor: appcolor,
                        //         content: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: <Widget>[
                        //             CircularProgressIndicator(),
                        //             SizedBox(
                        //               width: 10,
                        //             ),
                        //             Text('Please Wait'),
                        //           ],
                        //         ),
                        //       ));
                        //       login(
                        //         mobileNumber.text,
                        //       );
                        //       final signcode =
                        //           await SmsAutoFill().getAppSignature;
                        //     }

                        //     // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     //  builder: (BuildContext context) => HomaePage(
                        //     // )));
                        //   },
                        //   child: Text(
                        //     "SUBMIT",
                        //     style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w600,
                        //         color: white),
                        //   ),
                        // ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      // Text(
                      //   "We will send you an Onetime Password",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontSize: 14, fontWeight: FontWeight.w500),
                      // ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
