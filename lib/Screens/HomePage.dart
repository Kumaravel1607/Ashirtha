import 'package:asritha/Constant/API.dart';
import 'package:asritha/Constant/Colors.dart';
import 'package:asritha/Model/About_us.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Menu.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  SharedPreferences sharedPreferences;

  String id;

  @override
  void initState() {
    super.initState();
    // about_us();
    home_api();
    userID();
  }

  userID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    this.setState(() {
      id = sharedPreferences.getString("user_id");
    });
  }

  void home_api() async {
    var jsonResponse;
    var response = await http.get(app_api + "/banner");

    if (response.statusCode == 200) {
      get_banner(json.decode(response.body)['data']).then((value) {
        setState(() {
          banner = value;
        });
      });
      print("-------------------------");
      print(json.decode(response.body)['data']);
    }
  }

  String content = '';
  Future<AboutUs> about_us() async {
    var jsonResponse;
    var response = await http.get(app_api + "/about_us");
    // jsonResponse = json.decode(response.body)['data'];
    // print(jsonResponse);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body)['data'];
      print("-------------------------");
      print(jsonResponse);
      setState(() {
        content = json.decode(response.body)['data']['content'];
      });
      return AboutUs.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load post');
    }
  }

  List<BannerImage> banner = List<BannerImage>();

  Future<List<BannerImage>> get_banner(bannersJson) async {
    var banners = List<BannerImage>();
    for (var bannerJson in bannersJson) {
      banners.add(BannerImage.fromJson(bannerJson));
    }
    return banners;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appcolor,
        title: Image.asset(
          "assets/images/app_logo.png",
          height: 50,
          width: 50,
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      drawer: Drawer(
        child: MenuPage(),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 15,
              ),
              // Text(id),
              Container(
                // margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: banner_carousel(),
              ),
              SizedBox(height: 10),
              // Text(snapshot.data.content, style: TextStyle(color: black)),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ABOUT ASRITHAS GROUP:",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Over the past decade, property investment has become one of the most preferred investment options in India. The benefits of property investment are various. Among all the cities Hyderabad has emerged as one of the top destination to Invest. Steep growth in the IT sector and affordability in residential prices are the primary reasons behind Hyderabad’s emergence as a preferred destination.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 7),
                    Text(
                      "There are countless property investment opportunities in Hyderabad and Asrithas Group stands among the Top Best. The market in Hyderabad is cost-effective as compared to other cities in India. If you are searching for residential property or commercial investments, Asrithas Group would be a strong choice and will be your Final halt on your ‘Dream Home Search’.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 7),
                    Text(
                      "Here is what makes Asrithas Group stand ahead of other investment options, when it comes to investing in property in Hyderabad.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Investment in Eco-Friendliness at Asrithas Group",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Investing in Asrithas Group differentiates from the competition by integrating eco-friendly measures including Zero Discharge, Rain Water Harvesting and Solar system. These facilities have seamlessly been applied to the project design making an eco-friendly property and can help address the environmental concerns including water efficiency, energy efficiency and reduction in fossil fuel use, handling of waste and conserving natural resources. Most importantly, these initiatives will enhance the health and well-being of residents.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Your investment with Asrithas Group is investment in Reputation",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 7),
                    Text(
                      "For any property investment, it is always important to verify the reputation and track record of the builder. It is safer to invest in a property from an experienced builder who has a good track record of trust and transparency. A reputed builder will ensure a high quality of construction. The quality class depends on the building standards that were used at the time of construction. Asrithas Group has always meticulously built to the highest standard that depicts your lifestyle and the kind of environment that your family can thrive in.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "WHY ASRITHAS GROUP:",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "With Pioneering innovation in gated communities, we have been growing since 90’s,  Holding an unwavering vision to offer a sustainable balance between affordability and luxury, we bring you homes that enthral your heart. We build homes of global standards of construction with a great sense of environmental responsibility. Our mission has been to reach new heights and become the standard bearer of the real estate industry by creating the best living spaces. Our strength lies in our experience, skill and dedication to deliver the best. Keep showering your love and trust on us and we shall pursue our dreams, while we carry out yours!",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    // HtmlWidget(
                    //   content,
                    // ),
                  ],
                ),
              )
            ]),
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

  Widget banner_carousel() => banner.length != 0
      ? new Container(
          // height: MediaQuery.of(context).size.height / 2,
          child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                // aspectRatio: 2.0,
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.easeInCubic,
                enlargeCenterPage: false,
                reverse: false,
              ),
              itemCount: banner.length,
              itemBuilder: (context, index) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(banner[index].images),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.rectangle,
                          ),
                        ));
                  },
                );
              }),
        )
      : Container();
}
