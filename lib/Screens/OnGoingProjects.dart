import 'dart:io';

import 'package:asritha/Constant/API.dart';
import 'package:asritha/Constant/Colors.dart';
import 'package:asritha/Model/About_us.dart';
import 'package:asritha/Model/project_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:carousel_slider/carousel_options.dart';

class OnGoingProjects extends StatefulWidget {
  final String projectID;
  final String title;
  OnGoingProjects({Key key, this.projectID, this.title}) : super(key: key);

  @override
  _OnGoingProjectsState createState() => _OnGoingProjectsState();
}

class _OnGoingProjectsState extends State<OnGoingProjects> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    gallariView();
    project_detail();
  }

  void gallariView() async {
    var jsonResponse;
    var response =
        await http.get(app_api + "/on_projects_details/" + widget.projectID);
    if (response.statusCode == 200) {
      get_gallery(json.decode(response.body)['data']['images']).then((value) {
        setState(() {
          gallery = value;
        });
      });

      get_videos(json.decode(response.body)['data']['videos']).then((value) {
        setState(() {
          videos = value;
        });
      });
      print("-------------------------");
      print(json.decode(response.body)['data']['images']);
    }
  }

  List<GallaryView> gallery = List<GallaryView>();

  Future<List<GallaryView>> get_gallery(gallerysJson) async {
    var gallerys = List<GallaryView>();
    for (var galleryJson in gallerysJson) {
      gallerys.add(GallaryView.fromJson(galleryJson));
    }
    return gallerys;
  }

  List<Videos> videos = List<Videos>();

  Future<List<Videos>> get_videos(videosJson) async {
    var videos = List<Videos>();
    for (var videoJson in videosJson) {
      videos.add(Videos.fromJson(videoJson));
    }
    return videos;
  }

  Future<ProjectDetail> project_detail() async {
    var jsonResponse;
    var response =
        await http.post(app_api + "/on_projects_details/" + widget.projectID);
    // jsonResponse = json.decode(response.body)['data'];
    // print(jsonResponse);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body)['data'];
      // print("-------------------------");
      // print(jsonResponse);
      return ProjectDetail.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: appcolor,
        title: Text(
          widget.title,
          style: TextStyle(color: white, fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: FutureBuilder<ProjectDetail>(
                future: project_detail(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //  Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (BuildContext context) => photoView()));
                            },
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data.project_image),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          // SizedBox(height: 15,),

                          //  Container(
                          //     child: image_carousel(),
                          //   ),

                          Container(
                            padding: EdgeInsets.all(17),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data.project_name,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: appcolor,
                                      size: 18,
                                    ),
                                    Text(
                                      snapshot.data.location_name,
                                      style: TextStyle(color: appcolor),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                //  allImages(snapshot),
                                //   SizedBox(height:20),

                                HtmlWidget(
                                  snapshot.data.project_description,
                                  textStyle: TextStyle(),
                                ),

                                //  SizedBox(height:25),
                                //  Text("Videos",textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: black,fontWeight: FontWeight.w600),),
                                // SizedBox(height:5),
                                // Container(
                                //   height: 200,
                                //   child: Image.asset("assets/images/home_image.jpg"),
                                // ),
                                // SizedBox(height:25),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                        padding: EdgeInsets.only(top: 300),
                        alignment: Alignment.center,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ));
                  }
                }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(17, 25, 15, 17),
              child: Text(
                videos.length != 0 ? "Videos" : "",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20, color: black, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = videos[index];
                itemCount:
                videos.length;
                if (index > videos.length) return null;
                return Container(
                  height: 200,
                  child: WebView(
                    initialUrl: Uri.dataFromString(
                            '<html><body><iframe src="' +
                                videos[index].video_link +
                                '" width="100%" height="200" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe></body></html>',
                            mimeType: 'text/html')
                        .toString(),
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                );
              },
              childCount: videos.length,
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<ProjectDetail>(
                future: project_detail(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(17, 35, 17, 17),
                      child: Column(
                        children: [
                          ButtonTheme(
                            buttonColor: appcolor,
                            minWidth: 400,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: appcolor,
                                padding: EdgeInsets.all(13),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(color: appcolor)),
                              ),
                              // color: appcolor,
                              // padding: EdgeInsets.all(13),
                              // shape: RoundedRectangleBorder(
                              // borderRadius: BorderRadius.circular(15.0),
                              // side: BorderSide(color: appcolor)
                              // ),
                              onPressed: () async {
                                await launch(snapshot.data.download_brochure);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Download Brochure",
                                    style:
                                        TextStyle(color: white, fontSize: 16),
                                  ),
                                  SizedBox(width: 7),
                                  Icon(
                                    Icons.file_download,
                                    color: white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          ButtonTheme(
                            buttonColor: appcolor,
                            minWidth: 400,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: appcolor,
                                padding: EdgeInsets.all(13),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(color: appcolor)),
                              ),
                              // color: appcolor,
                              // padding: EdgeInsets.all(13),
                              // shape: RoundedRectangleBorder(
                              // borderRadius: BorderRadius.circular(15.0),
                              // side: BorderSide(color: appcolor)
                              // ),
                              onPressed: () async {
                                await launch(snapshot.data.download_layout);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Download Layout",
                                    style:
                                        TextStyle(color: white, fontSize: 16),
                                  ),
                                  SizedBox(width: 7),
                                  Icon(
                                    Icons.file_download,
                                    color: white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ]),
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

  Widget image_carousel() => new Container(
        // height: MediaQuery.of(context).size.height / 2,
        child: CarouselSlider.builder(
            options: CarouselOptions(
              height: 230,
              viewportFraction: 1.0,
              // aspectRatio: 2.0,
              autoPlay: true,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayCurve: Curves.fastOutSlowIn,
              // enlargeCenterPage: false,
            ),
            itemCount: gallery.length,
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
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              gallery[index].image_url,
                            ),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ));
                },
              );
            }),
      );

//  int _pageIndex = 0;

//    Widget photoView() => Container(
//         child: PhotoViewGallery.builder(
//             itemCount: gallery.length,
//             builder: (context, index) {
//               print(gallery[index].image_url);
//               return PhotoViewGalleryPageOptions(
//                 imageProvider: NetworkImage(gallery[index].image_url),
//                 minScale: PhotoViewComputedScale.contained * 0.8,
//                 maxScale: PhotoViewComputedScale.covered * 2,
//               );
//             },
//             scrollPhysics: BouncingScrollPhysics(),
//             backgroundDecoration: BoxDecoration(
//               color: black,
//             ),
//             loadFailedChild: Container(
//               alignment: Alignment.center,
//               child: CircularProgressIndicator(),
//             )),
//       );

//        Widget allImages(AsyncSnapshot<ProjectDetail> snapshot) => Container(
//       height: 200,
//       color: appcolor,
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: NetworkImage(snapshot.data.project_image),
//                     fit: BoxFit.fill)),
//           ),
//           Container(
//               padding: EdgeInsets.all(20),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               alignment: Alignment.centerRight,
//               color: Colors.grey.withOpacity(0.6),
//               child: GestureDetector(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "+" + gallery.length.toString(),
//                       style: TextStyle(
//                         fontSize: 26,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "IMAGES",
//                       style: TextStyle(
//                         fontSize: 26,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 onTap: () => gallery.length.toString() == "0"
//                     ? {}
//                     : Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (BuildContext context) => photoView())),
//               ))
//         ],
//       ));
}
