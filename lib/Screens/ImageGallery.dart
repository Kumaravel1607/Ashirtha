import 'package:asritha/Constant/API.dart';
import 'package:asritha/Constant/Colors.dart';
import 'package:asritha/Model/project_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageGallery extends StatefulWidget {
  final String projectId;
  final String galleryId;
  final String title;
  //  final int initialIndex;
  // final PageController pageController;

  ImageGallery({
    Key key,
    this.projectId,
    this.galleryId,
    this.title,
  });

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  bool _isLoading = false;
  int currentIndex;
  int initialIndex;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    project_gallery_View();
    // currentIndex = initialIndex;
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void refresh() {
    setState(() {
      _controller = PageController(initialPage: currentIndex);
    });
  }

  void project_gallery_View() async {
    var jsonResponse;
    var response = await http.get(app_api +
        "/project_gallery/" +
        widget.projectId +
        '/' +
        widget.galleryId);
    print(app_api +
        "/project_gallery/" +
        widget.projectId +
        '/' +
        widget.galleryId);
    print('ooooo--------------oooooooooo--------');
    if (response.statusCode == 200) {
      get_gallery(json.decode(response.body)['data']).then((value) {
        setState(() {
          gallery = value;
        });
      });

      print('----------------------------');
      print(app_api +
          "/project_gallery/" +
          widget.projectId +
          '/' +
          widget.galleryId);
      print(json.decode(response.body)['data']);
    }
  }

  List<Project_Gallery> gallery = List<Project_Gallery>();

  Future<List<Project_Gallery>> get_gallery(gallerysJson) async {
    var gallerys = List<Project_Gallery>();
    for (var galleryJson in gallerysJson) {
      gallerys.add(Project_Gallery.fromJson(galleryJson));
    }
    return gallerys;
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appcolor,
        title: Text(
          widget.title,
          style: TextStyle(
            color: white,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: gallery.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(7),
            child: InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;

                    refresh();
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => photoView()));
                  //  Navigator.push(context, new MaterialPageRoute(
                  //   fullscreenDialog: true,
                  //   builder: (BuildContext context) {
                  //     return new Scaffold(
                  //        backgroundColor: black,
                  //       appBar: AppBar(
                  //         backgroundColor: black,
                  //         title: Text(gallery[index].gallery_description, style: TextStyle(color:white, fontSize: 16 ),),
                  //           centerTitle: true,
                  //       ),
                  //       body: GestureDetector(
                  //       onTap: (){
                  //         Navigator.pop(context);
                  //       },
                  //       child: Container(
                  //         height: MediaQuery.of(context).size.height,
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           new Hero(
                  //         tag: "preview",
                  //         child: Center(
                  //           child:new Image(
                  //           image: new  NetworkImage(gallery[index].gallery_name),
                  //         ),
                  //         )
                  //       ),
                  //       // Text(gallery[index].gallery_description, style: TextStyle(color:white, fontSize: 16 ),),
                  //         ],
                  //       ),
                  //     ),
                  //     ),
                  //     );
                  //   }
                  //   ));
                },
                child: Stack(
                  children: [
                    Container(
                      // height: 130,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          // borderRadius: BorderRadius.only(
                          //     topRight: Radius.circular(7.0),
                          //     topLeft: Radius.circular(7.0)),
                          color: appcolor,
                          image: DecorationImage(
                              image: NetworkImage(gallery[index].gallery_name),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.all(10),
                      // height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        // color: appcolor,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        // margin: EdgeInsets.all(10),
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(7.0),
                              bottomRight: Radius.circular(7.0)),
                          color: Colors.white,
                          // color: Colors.white.withOpacity(0.7),
                        ),
                        child: Text(
                          " " + gallery[index].gallery_description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                )
                //    new Card(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         height: 130,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.only(
                //               topRight: Radius.circular(7.0),
                //               topLeft: Radius.circular(7.0)),
                //           color: appcolor,
                //           image: DecorationImage(image: NetworkImage(gallery[index].gallery_name), fit: BoxFit.cover)
                //         ),

                //       ),
                //       SizedBox(height: 3,),
                //        Text("   "+gallery[index].gallery_description,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12, color: black,fontWeight: FontWeight.w500),),

                //     ],
                //   ),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(7.0),
                //   ),
                //   elevation: 5,
                //   // margin: EdgeInsets.all(10),
                // ),
                ),
          );
        },
      ),
    );
  }

  Widget photoView() {
    return Container(
      child: Stack(
        children: [
          PhotoViewGallery.builder(
              itemCount: gallery.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  initialScale: PhotoViewComputedScale.contained * 0.9,
                  imageProvider: NetworkImage(
                    gallery[index].gallery_name,
                  ),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  // heroAttributes: PhotoViewHeroAttributes(tag: "tag2"),
                );
              },
              pageController: _controller,
              onPageChanged: onPageChanged,
              scrollPhysics: BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(
                color: black,
              ),
              loadFailedChild: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  backgroundColor: appcolor,
                  valueColor: new AlwaysStoppedAnimation<Color>(white),
                ),
              )),
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(top: 100, right: 25),
            child: FloatingActionButton(
              elevation: 10,
              mini: true,
              foregroundColor: black,
              backgroundColor: white,
              child: Icon(
                Icons.close,
                color: black,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
