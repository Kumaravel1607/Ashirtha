import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);
const appcolor = Color(0xFF188D3D);
const appcolor2 = Color(0xFF8EC826);
const montserrat = 'Montserrat';

textDecoration(hint, icon) => InputDecoration(
      fillColor: white,
      prefixIcon: Icon(
        icon,
        color: black,
      ),
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
      hintText: (hint),
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16.0,
      ),
      border: new UnderlineInputBorder(
        borderSide: new BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(3.0),
      ),
      focusedErrorBorder: new UnderlineInputBorder(
        borderSide: BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(3.0),
      ),
      errorBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(3.0),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(3.0),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );

contactTextDecoration(hint) => InputDecoration(
      fillColor: white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      hintText: (hint),
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16.0,
      ),
      border: new OutlineInputBorder(
        borderSide: new BorderSide(color: appcolor, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedErrorBorder: new OutlineInputBorder(
        borderSide: BorderSide(color: appcolor, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      errorBorder: new OutlineInputBorder(
        borderSide: new BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: appcolor, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: appcolor, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );

textDecoration3(hint) => InputDecoration(
      fillColor: white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
      hintText: (hint),
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 15.0,
      ),
      border: new UnderlineInputBorder(
        borderSide: new BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(3.0),
      ),
      focusedErrorBorder: new UnderlineInputBorder(
        borderSide: BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(3.0),
      ),
      errorBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(3.0),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(3.0),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: appcolor, width: 1.5),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );

void whatsapp() async {
  const url = 'https://wa.me/919392777871';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void telephone() async {
  const url = "tel:04048569953";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void phone() async {
  const url = 'tel:9392777871';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void mail() async {
  const url = 'mailto:queries@asrithasgroup.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void fb() async {
  const url = 'https://www.facebook.com/AsrithasGroupHyd/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void twitter() async {
  const url = 'https://twitter.com/Asrithas_Group';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void insta() async {
  const url = 'https://www.instagram.com/asrithas_group/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void youtube() async {
  const url = 'https://www.youtube.com/channel/UClEkjYz23uANztzp1dKc3OA';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void linkedin() async {
  const url = 'https://www.linkedin.com/company/asrithasgroup/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
