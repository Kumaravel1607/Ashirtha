import 'package:asritha/Constant/API.dart';
import 'package:asritha/Constant/Colors.dart';
import 'package:asritha/Model/project_model.dart';
import 'package:asritha/Screens/Menu.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'OnGoingProjects.dart';
import 'ProjectUpdates.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ProjectListPage extends StatefulWidget {
  final projectID;
  ProjectListPage({Key key, this.projectID}) : super(key: key);

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  SharedPreferences sharedPreferences;

   @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 300),
      () => project_list(),
    );
    // project_list();
  }

  void project_list() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Map data = {
    //   'user_id': sharedPreferences.getString("login_id"),
    // };
    var jsonResponse;
    var response = widget.projectID == 1 ? await http.get(app_api + '/on_projects') : await http.get(app_api + '/update_projects');

    if (response.statusCode == 200) {
      get_projectList(json.decode(response.body)['data']).then((value) {
        setState(() {
          projects = value;
        });
      });
      print('---------------NK-----------');
      print(json.decode(response.body)['data']);
    }
  }

  List<ProjectList> projects = List<ProjectList>();

  Future<List<ProjectList>> get_projectList(projectsJson) async {
    var projects = List<ProjectList>();
    for (var projectJson in projectsJson) {
      projects.add(ProjectList.fromJson(projectJson));
    }
    return projects;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: appcolor,
         title: widget.projectID == 1 ? Text("OnGoing Projects", style: TextStyle(color:white, ),) :Text("Project Updates", style: TextStyle(color:white, ),),
          centerTitle: true,
       ),
       drawer: Drawer(
         child: MenuPage(),
       ),
       body: Stack(children: [
        //   SingleChildScrollView(
        //  child: 
        projectList(),
      //  ), 
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
  
  Widget projectList(){
    return widget.projectID == 1 ? projects.length == 0 ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(backgroundColor: appcolor,valueColor: new AlwaysStoppedAnimation<Color>(white),),
            ) : new ListView.builder(
      shrinkWrap: false,
      scrollDirection: Axis.vertical,
      itemCount: projects.length,
      itemBuilder: (context, index) { 
        return GestureDetector(
      onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
               OnGoingProjects(
                 projectID: projects[index].id,title: projects[index].project_name,),),);
      },
      child:Padding(padding: EdgeInsets.fromLTRB(17, 17, 17,0),
          child: Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
             height: 200,
              // width: 250,
              decoration: BoxDecoration(
                color: white,
                border: Border.all(color: Colors.grey[100]),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0), topRight: Radius.circular(7.0),),
                image: DecorationImage(
                    image: NetworkImage(projects[index].project_image),
                    fit: BoxFit.fill),
              ),
          ),
          Padding(padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Text(projects[index].project_name,textAlign: TextAlign.start, style: TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w600),),
              SizedBox(height: 5,),
             Text("Location: "+projects[index].location_name,textAlign: TextAlign.start, style: TextStyle(fontSize: 12, color: appcolor,fontWeight: FontWeight.w500),),
            ],
          ),
          )
        ],
      ),
      ),
      ),
    );
      }
    ) : projects.length == 0 ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(backgroundColor: appcolor,valueColor: new AlwaysStoppedAnimation<Color>(white),),
            ): ListView.builder(
      shrinkWrap: false,
      scrollDirection: Axis.vertical,
      itemCount: projects.length,
      itemBuilder: (context, index) { 
        return GestureDetector(
      onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
               ProjectUpdatesPage(projectID: projects[index].id,title: projects[index].project_name,) ));
      },
      child:Padding(padding: EdgeInsets.fromLTRB(17, 17, 17,0),
          child: Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Padding(padding: EdgeInsets.fromLTRB(10,10,0,10),
          child: Row(
            children: [
              Expanded(
                flex: 10,
                child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Text(projects[index].project_name,textAlign: TextAlign.start, style: TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w600),),
              SizedBox(height: 5,),
             Text("Location: "+projects[index].location_name,textAlign: TextAlign.start, style: TextStyle(fontSize: 12, color: appcolor,fontWeight: FontWeight.w500),),
            ],
          ),),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (BuildContext context) =>
               ProjectUpdatesPage() ));
              },
              child: Container(
              // color: appcolor,
              child: Icon(Icons.arrow_forward, color: appcolor,),
            ),),
            )
            ],
          )
          ),
      ),
      ),
    );
      }
    );
  }
}
