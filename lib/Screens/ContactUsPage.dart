import 'package:asritha/Constant/API.dart';
import 'package:asritha/Constant/Colors.dart';
import 'package:asritha/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ContactUsPage extends StatefulWidget {
  ContactUsPage({Key key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

final TextEditingController email = new TextEditingController();
final TextEditingController message = new TextEditingController();

class _ContactUsPageState extends State<ContactUsPage> {
  bool _isLoading = false;
  SharedPreferences sharedPreferences;

  sendmessage(
    msg,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'user_id': sharedPreferences.getString("user_id"),
      'message': msg,
    };
    print(data);
    var jsonResponse;
    var response =
        await http.post(app_api + "/send_message", body: jsonEncode(data));
    jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        _alerDialog(jsonResponse['message']);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      }
    } else {
      jsonResponse = json.decode(response.body);
      _alerDialog(jsonResponse['message']);
      setState(() {
        _isLoading = false;
      });
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
            content: Text("Please Write your message"),
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
      appBar: AppBar(
        backgroundColor: appcolor,
        title: Text(
          "Contact Us",
          style: TextStyle(
            color: white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We'd Love to Hear from you",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 24, color: black, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 30,
                ),
                //   TextFormField(
                //   validator: (value) {
                //     if (value.isEmpty) {
                //       return 'Please enter Eamil';
                //     }
                //     return null;
                //   },
                //   cursorHeight: 18,
                //   onSaved: (String value) {},
                //   controller: email,
                //   obscureText: false,
                //   style: TextStyle(
                //     fontSize: 14.0,
                //     color: black,
                //   ),
                //   keyboardType: TextInputType.text,
                //   decoration: contactTextDecoration('Enter Your Email'),
                // ),
                // SizedBox(height: 20,),
                TextFormField(
                  maxLines: 5,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Write Message';
                    }
                    return null;
                  },
                  cursorHeight: 18,
                  onSaved: (String value) {},
                  controller: message,
                  obscureText: false,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: black,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: contactTextDecoration('Write Your Message'),
                ),
                SizedBox(height: 30),
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
                    // style:  ButtonStyle(backgroundColor:MaterialStateProperty.all(appcolor),
                    // padding: EdgeInsets.all(13), ) ,
                    // color: appcolor,
                    // padding: EdgeInsets.all(13),
                    // shape: RoundedRectangleBorder(
                    // borderRadius: BorderRadius.circular(10.0),
                    // side: BorderSide(color: appcolor)
                    // ),
                    onPressed: () {
                      if (message.text.isEmpty) {
                        _alerBox();
                      } else {
                        sendmessage(
                          message.text,
                        );
                      }
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: appcolor,
                    ),
                    SizedBox(width: 7),
                    Text(
                      "Office Address",
                      style: TextStyle(
                          color: black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "  Door No 112, Flat No 302, 3rd Floor,",
                  style: TextStyle(
                      color: black, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Text(
                  "  Kavuri Hills Phase 1,",
                  style: TextStyle(
                      color: black, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Text(
                  "  ICONIA Building, Madhapur,",
                  style: TextStyle(
                      color: black, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Text(
                  "  Hyderabad, Telangana 500033,",
                  style: TextStyle(
                      color: black, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                // ListTile(
                //   title: Text("LandLine", style: TextStyle(color: black, fontSize: 17, fontWeight: FontWeight.bold),),
                //   leading: Icon(Icons.phone_android,color: appcolor,),
                //   subtitle: Text("  040-48569953", style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),),
                // ),
                GestureDetector(
                  onTap: telephone,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_android,
                              color: appcolor,
                            ),
                            SizedBox(width: 7),
                            Text(
                              "Office Number",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          "  040-48569953",
                          style: TextStyle(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: phone,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              color: appcolor,
                            ),
                            SizedBox(width: 7),
                            Text(
                              "Phone",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          "  +91 9392777871",
                          style: TextStyle(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: mail,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail,
                              color: appcolor,
                            ),
                            SizedBox(width: 7),
                            Text(
                              "E-mail",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          "  queries@asrithasgroup.com",
                          style: TextStyle(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
                SizedBox(height: 20),
                Text(
                  " Follow Us",
                  style: TextStyle(
                      color: black, fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.facebookSquare,
                        size: 40,
                        color: appcolor,
                      ),
                      onPressed: fb,
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.twitterSquare,
                        size: 40,
                        color: appcolor,
                      ),
                      onPressed: twitter,
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.instagramSquare,
                        size: 40,
                        color: appcolor,
                      ),
                      onPressed: insta,
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.youtubeSquare,
                        size: 40,
                        color: appcolor,
                      ),
                      onPressed: youtube,
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.linkedin,
                        size: 40,
                        color: appcolor,
                      ),
                      onPressed: linkedin,
                    ),
                  ],
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Icon(Icons.mail,color: appcolor,),
                //           SizedBox(width:7),
                //           Text("E-mail", style: TextStyle(color: black, fontSize: 17, fontWeight: FontWeight.bold),),
                //         ],
                //       ),
                //     Text("  info@asrithasgroup.com", style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),),
                //       ],
                //     ),
                //     Spacer(),
                //     GestureDetector(
                //       onTap: (){},
                //       child: Image.asset("assets/images/whatsapp.png"),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: GestureDetector(
            onTap: () {
              whatsapp();
            },
            child: Image.asset("assets/images/whatsapp.png"),
          ),
        )
      ]),
    );
  }
}
