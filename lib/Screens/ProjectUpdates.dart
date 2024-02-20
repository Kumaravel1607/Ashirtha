
import 'dart:io';

import 'package:asritha/Constant/API.dart';
import 'package:asritha/Constant/Colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:asritha/Model/project_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

import 'ImageGallery.dart';

class ProjectUpdatesPage extends StatefulWidget {
  final String projectID;
  final String title;
  ProjectUpdatesPage({Key key, this.projectID, this.title}) : super(key: key);

  @override
  _ProjectUpdatesPageState createState() => _ProjectUpdatesPageState();
}

class _ProjectUpdatesPageState extends State<ProjectUpdatesPage> {

  bool _isLoading = false;
  String title = "";

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    image_video_View();
    project_detail();
  }

  void image_video_View() async {

    var jsonResponse;
    var response = await http.get(app_api + "/update_projects_details/"+widget.projectID);
    if (response.statusCode == 200) {
      get_images(json.decode(response.body)['data']['images']).then((value) {
        setState(() {
          gallery = value;
        });
      });
      

      get_videos(json.decode(response.body)['data']['videos']).then((value) {
        setState(() {
          videos = value;
        });
      });

      get_gallerys_images(json.decode(response.body)['data']['gallery_date']).then((value) {
        setState(() {
          getGallery = value;
        });
      });

      print("-------------------------");
      print(json.decode(response.body)['data']['gallery_date']);
    }
  }

   List<GallaryView> gallery = List<GallaryView>();

  Future<List<GallaryView>> get_images(gallerysJson) async {
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

   List<Gallery> getGallery = List<Gallery>();

  Future<List<Gallery>> get_gallerys_images(gallerysJson) async {
    var galleryImages = List<Gallery>();
    for (var galleryJson in gallerysJson) {
      galleryImages.add(Gallery.fromJson(galleryJson));
    }
    return galleryImages;
  }

  Future<ProjectDetail> project_detail() async {

    var jsonResponse;
    var response = await http.post(app_api + "/update_projects_details/"+widget.projectID);
    jsonResponse = json.decode(response.body)['data'];
    // print('----------------------------------------------------------------------------');
    // print(jsonResponse);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body)['data'];
      // print("-------------------------");
      // print(jsonResponse);
      title = jsonResponse['project_name'];
      return ProjectDetail.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
       backgroundColor: white,
       appBar: AppBar(
         backgroundColor: appcolor,
         title: Text(title, style: TextStyle(color:white, fontSize: 16 ),),
          centerTitle: true,
       ),
       body:Stack(children: [
         CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: FutureBuilder<ProjectDetail>(
            future: project_detail(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
             return Container(child: Column(
           children: [
            //  Container(
            //    height: 250,
            //    decoration: BoxDecoration(
            //      image: DecorationImage(
            //        image: NetworkImage(snapshot.data.project_image),
            //        fit: BoxFit.fill
            //      ),
            //    ),
            //  ),
            SizedBox(height: 10,),
              Container(
                child: image_carousel(),
              ),
             Container(
               padding: EdgeInsets.fromLTRB(17,17,17,7),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  Text(snapshot.data.project_name,textAlign: TextAlign.start, style: TextStyle(fontSize: 16, color: black,fontWeight: FontWeight.w600),),
                  SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: appcolor, size: 18,),
                        Text(snapshot.data.location_name, style: TextStyle(color: appcolor),)
                      ],
                    ),
                      SizedBox(height:30),
                    // allImages(snapshot),
                    // SizedBox(height:20),
                    // HtmlWidget(
                    //     snapshot.data.project_description,
                    //   ),

                  Text(getGallery.length != 0 ? "Project Gallery" : "",textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: black,fontWeight: FontWeight.w600),),
                    // IconButton(
                    //   icon: FaIcon(FontAwesomeIcons.images,size: 40,color: appcolor,), 
                    //   onPressed: (){
                    //     Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (BuildContext context) => ImageGallery()));
                    //   },
                    // ),

                    
                  
                  SizedBox(height:15),
                  
                  // SizedBox(height:5),
                 ],
               ),
             )
           ],
         ),
          );
              } else{
                return Container(
                  padding: EdgeInsets.only(top:300),
                  alignment: Alignment.center,
                  child:Center(child: CircularProgressIndicator(backgroundColor: appcolor,valueColor: new AlwaysStoppedAnimation<Color>(white),),));
              }
            }
           )
         ),
          // GridView.builder(
          //             itemCount: gallery.length,
          //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
          //             itemBuilder: (BuildContext context, int index) {
          //               return new Card(
          //                 child: Column(
          //                   children: [
          //                     Container(
          //                       child: Image.network(
          //                       gallery[index].image_url,
          //                       fit: BoxFit.cover,
          //                     ),
          //                     ),
          //                   ],
          //                 ),
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(10.0),
          //                 ),
          //                 elevation: 5,
          //                 margin: EdgeInsets.all(10),
          //               );
          //             },
          //           ),
          // SliverGrid.count(crossAxisCount: 3),
          // SliverGrid(delegate: null, gridDelegate: null)
          SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildBuilderDelegate((BuildContext context, int index){
               final item = getGallery[index];
               print(getGallery[index]);
              itemCount: getGallery.length;
                  if (index > getGallery.length) return null;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                child: InkWell(
                  onTap: (){
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) =>
                         ImageGallery(projectId: widget.projectID, galleryId:getGallery[index].gallery_id, title:getGallery[index].gallery_folder )));
                  },
                  child: Card(
                    elevation: 8.0,
                    child: Column(children: [
                       Image.asset('assets/images/gallery.png', width: 80,height: 80,),
                      Text(getGallery[index].gallery_folder,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12, color: black,fontWeight: FontWeight.w500),),
                      Text('('+getGallery[index].total_count+')',style: TextStyle(fontSize: 12, color: black,fontWeight: FontWeight.w500),),
                    ],)  ),
                  )
                );
              },
              childCount: getGallery.length, // Your desired amount of children here 
            ),
          ),
        SliverToBoxAdapter(
        child: Padding(padding: EdgeInsets.fromLTRB(17,30,15,17),
         child: Text(videos.length != 0 ? "Videos" : "",textAlign: TextAlign.start, style: TextStyle(fontSize: 20, color: black,fontWeight: FontWeight.w600),),
        ),
        ),
         SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final item = videos[index];
              itemCount: videos.length;
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
          ]
         ),
         
         Container(
           alignment: Alignment.bottomRight,
           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
           child: GestureDetector(
                  onTap: (){
                    whatsapp();
                  },
                  child: Image.asset("assets/images/whatsapp.png"),
                ),
         )
         ]
         ),
    );
  }

  
   Widget photoView() => Container(
        child: PhotoViewGallery.builder(
            itemCount: gallery.length,
            builder: (context, index) {
              print(gallery[index].image_url);
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(gallery[index].image_url),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color: black,
            ),
            loadFailedChild: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(backgroundColor: appcolor,valueColor: new AlwaysStoppedAnimation<Color>(white),),
            )),
      );


      Widget allImages(AsyncSnapshot<ProjectDetail> snapshot) => Container(
      height: 200,
      color: appcolor,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(snapshot.data.project_image),
                    fit: BoxFit.fill)),
          ),
          Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.centerRight,
              color: Colors.grey.withOpacity(0.6),
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "+" + gallery.length.toString(),
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "IMAGES",
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onTap: () => gallery.length.toString() == "0"
                    ? {}
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => photoView())),
              ))
        ],
      ));

       Widget image_carousel() => gallery.length != null ? new Container(
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
                  decoration: BoxDecoration(color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(gallery[index].image_url,),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                  ),
                  )
                  );
            },
          );
        }),
      ): Container();
      
}
