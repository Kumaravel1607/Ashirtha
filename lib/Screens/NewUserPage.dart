import 'package:asritha/Constant/API.dart';
import 'package:asritha/Constant/Colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

class NewUserPage extends StatefulWidget {
  final String mobilenum;
  NewUserPage({Key key, this.mobilenum}) : super(key: key);

  @override
  _NewUserPageState createState() => _NewUserPageState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController name = new TextEditingController();
final TextEditingController email = new TextEditingController();
final TextEditingController projectName = new TextEditingController();
final TextEditingController dob = new TextEditingController();
final TextEditingController anniversary = new TextEditingController();
final TextEditingController flat = new TextEditingController();
final TextEditingController plot = new TextEditingController();

int user = 1;
String _projectName = '';
String block = '';

class _NewUserPageState extends State<NewUserPage> {
  DateTime _selectedDate;
  String firebase_id;
  SharedPreferences sharedPreferences;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getMessage();
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
      firebase_id = token;
    });
  }

  register(
    email,
    name,
    projectType,
    dob,
    plot,
    flat,
    aniversaryDate,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'mobile': widget.mobilenum,
      'user_type': user,
      'email': email,
      'name': name,
      'project_type': projectType,
      'dob': dob,
      'plot': plot,
      'flat': flat,
      'aniversary_data': aniversaryDate,
      'app_id': firebase_id,
    };

    print(data);
    var jsonResponse;
    var response =
        await http.post(app_api + "/save_user", body: jsonEncode(data));
    // jsonResponse = json.decode(response.body);
    // print(jsonResponse);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        sharedPreferences.setString("user_id",
            json.decode(response.body)['data']['user_id'].toString());

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
        // _alerDialog(jsonResponse['message']);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      _alerDialog(jsonResponse['message']);
    }
  }

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
            content: Text("Please fill Required field"),
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
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Text(
                      "Select User",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 1,
                      groupValue: user,
                      activeColor: appcolor,
                      onChanged: (value) {
                        setState(() {
                          user = value;
                          _projectName = '';
                          print(user);
                        });
                      },
                    ),
                    Text(
                      "Existing User",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    //  SizedBox(width: 15,),
                    Spacer(),
                    Radio(
                      value: 2,
                      groupValue: user,
                      activeColor: appcolor,
                      onChanged: (value) {
                        setState(() {
                          user = value;
                          _projectName = '';
                          print(user);
                        });
                      },
                    ),
                    Text(
                      "New User",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: Text(
                    "Name *",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: appcolor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                  cursorHeight: 18,
                  onSaved: (String value) {},
                  controller: name,
                  obscureText: false,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: black,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: textDecoration('Enter Your Name', Icons.person),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: Text(
                    "Email *",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: appcolor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Valid Email';
                    }
                    return null;
                  },
                  cursorHeight: 18,
                  onSaved: (String value) {},
                  controller: email,
                  obscureText: false,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: black,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: textDecoration('Enter E-mail', Icons.email),
                ),
                SizedBox(
                  height: 30,
                ),
                user == 1
                    ? Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: Text(
                          "Project Name *",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17,
                              color: appcolor,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : SizedBox(),
                user == 1
                    ? DropdownButtonFormField<String>(
                        decoration: textDecoration('Select Project',
                            Icons.home_repair_service_rounded),
                        items: <String>[
                          'Jewels County',
                          '14th Residency',
                          '14th Avenue',
                        ]
                            .map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: black,
                                      fontFamily: montserrat,
                                      fontSize: 16,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _projectName = newValue;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select the Project' : null,
                      )
                    : SizedBox(),
                user == 2
                    ? Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: Text(
                          "Looking for *",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17,
                              color: appcolor,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : SizedBox(),
                user == 2
                    ? DropdownButtonFormField<String>(
                        decoration: textDecoration(
                            'Choose option', Icons.home_repair_service_rounded),
                        items: <String>[
                          'Apartment',
                          'Open Plot',
                        ]
                            .map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: black,
                                      fontFamily: montserrat,
                                      fontSize: 16,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _projectName = newValue;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select option' : null,
                      )
                    : SizedBox(),
                SizedBox(
                  height: 30,
                ),
                _projectName == '' || user == 2
                    ? SizedBox()
                    : _projectName == 'Jewels County'
                        ? Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 13),
                                  child: Text(
                                    "Flat *",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: appcolor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Block *",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: appcolor,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: 13),
                            child: Text(
                              "Plot *",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: appcolor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                _projectName == '' || user == 2
                    ? SizedBox()
                    : _projectName == 'Jewels County'
                        ? Row(children: [
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Flat';
                                  }
                                  return null;
                                },
                                cursorHeight: 18,
                                onSaved: (String value) {},
                                controller: flat,
                                obscureText: false,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: black,
                                ),
                                keyboardType: TextInputType.text,
                                decoration:
                                    textDecoration('Flat No', Icons.apartment),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                decoration: textDecoration3('Block'),
                                items: <String>[
                                  'A',
                                  'B',
                                  'C',
                                  'D',
                                ]
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              color: black,
                                              fontFamily: montserrat,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    block = newValue;
                                  });
                                },
                                validator: (value) =>
                                    value == null ? 'Select block' : null,
                              ),
                            ),
                          ])
                        : TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Plot No';
                              }
                              return null;
                            },
                            cursorHeight: 18,
                            onSaved: (String value) {},
                            controller: plot,
                            obscureText: false,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: black,
                            ),
                            keyboardType: TextInputType.text,
                            decoration:
                                textDecoration('Plot No', Icons.apartment),
                          ),
                _projectName == '' || user == 2
                    ? SizedBox()
                    : SizedBox(
                        height: 30,
                      ),
                Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: Text(
                    "Date Of Birth",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: appcolor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextFormField(
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter Your DOB';
                  //   }
                  //   return null;
                  // },
                  focusNode: AlwaysDisabledFocusNode(),
                  onTap: () {
                    _selectDate(context);
                  },
                  cursorHeight: 18,
                  onSaved: (String value) {},
                  controller: dob,
                  obscureText: false,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: black,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: textDecoration('Date of Birth', Icons.date_range),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: Text(
                    "Anniversary Date",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: appcolor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextFormField(
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter Anniversary Date';
                  //   }
                  //   return null;
                  // },
                  cursorHeight: 18,
                  onSaved: (String value) {},
                  controller: anniversary,
                  obscureText: false,
                  focusNode: AlwaysDisabledFocusNode(),
                  onTap: () {
                    _selectDate2(context);
                  },
                  style: TextStyle(
                    fontSize: 14.0,
                    color: black,
                  ),
                  keyboardType: TextInputType.text,
                  decoration:
                      textDecoration('Date of Anniversary', Icons.date_range),
                ),
                SizedBox(
                  height: 45,
                ),
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
                    // borderRadius: BorderRadius.circular(10.0),
                    // side: BorderSide(color: appcolor)
                    // ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print("-------");
                        register(
                          email.text,
                          name.text,
                          _projectName,
                          dob.text,
                          plot.text,
                          flat.text,
                          anniversary.text,
                        );
                      }

                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomaePage()),
                      // );
                    },
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: appcolor,
                onPrimary: Colors.white,
                surface: appcolor,
                onSurface: black,
              ),
              dialogBackgroundColor: white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      dob
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dob.text.length, affinity: TextAffinity.upstream));
    }
  }

  _selectDate2(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: appcolor,
                onPrimary: Colors.white,
                surface: appcolor,
                onSurface: black,
              ),
              dialogBackgroundColor: white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      anniversary
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: anniversary.text.length, affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
