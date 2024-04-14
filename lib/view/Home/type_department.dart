import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sbbwu_navigator/view/Home/bank.dart';
import 'package:sbbwu_navigator/view/Home/canteen.dart';
import 'package:sbbwu_navigator/view/Home/dapartment.dart';
import 'package:sbbwu_navigator/view/Home/hostel.dart';

import '../../widgets/custom_message.dart';
import '../auth/login_screen.dart';
import '../google_map/google_map_screen.dart';
import 'dvc_hall.dart';

class TypeDepartment extends StatefulWidget {
  const TypeDepartment({Key? key}) : super(key: key);

  @override
  State<TypeDepartment> createState() => _TypeDepartmentState();
}

class _TypeDepartmentState extends State<TypeDepartment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              FirebaseAuth.instance.signOut().then((value){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                FlutterToast().flutterToastMessage(context, "You account has sign out");
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                  Icons.exit_to_app
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            child: ListTile(
              title: Text("Departments",style: TextStyle(color: Colors.white),),
              trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentPage()));
              },
            ),
          ),
          Card(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            child: ListTile(
              title: Text("Halls",style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DVCHallPage()));
              },
            ),
          ),
          Card(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            child: ListTile(
              title: Text("Canteen",style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CanteenPage()));
              },
            ),
          ),
          Card(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            child: ListTile(
              title: Text("Hostel",style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HostelPage()));
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("bank").snapshots(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            var latitude = double.parse(snapshot.data!.docs[index]["latitude"]);
                            var longitude = double.parse(snapshot.data!.docs[index]["longitude"]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMapPage(
                              latitude: latitude,
                              longitude: longitude,
                              departmentName: snapshot.data!.docs[index]["type"],
                            )));
                          },
                          child: Card(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: ListTile(
                              title: Text("${snapshot.data!.docs[index]["type"]}",style: GoogleFonts.aBeeZee(
                                color: Colors.white,
                              ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                            ),
                          ),
                        );
                      }
                  );
                }else{
                  return Center(child: SizedBox());
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("dealingOffice").snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              var latitude = double.parse(snapshot.data!.docs[index]["latitude"]);
                              var longitude = double.parse(snapshot.data!.docs[index]["longitude"]);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMapPage(
                                latitude: latitude,
                                longitude: longitude,
                                departmentName: snapshot.data!.docs[index]["type"],
                              )));
                            },
                            child: Card(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: ListTile(
                                title: Text("${snapshot.data!.docs[index]["type"]}",style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                ),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                              ),
                            ),
                          );
                        }
                    );
                  }else{
                    return Center(child: SizedBox());
                  }
                },
              ),
          ),
          Expanded(
            flex: 1,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("admissionSection").snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              var latitude = double.parse(snapshot.data!.docs[index]["latitude"]);
                              var longitude = double.parse(snapshot.data!.docs[index]["longitude"]);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMapPage(
                                latitude: latitude,
                                longitude: longitude,
                                departmentName: snapshot.data!.docs[index]["type"],
                              )));
                            },
                            child: Card(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: ListTile(
                                title: Text("${snapshot.data!.docs[index]["type"]}",style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                ),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                              ),
                            ),
                          );
                        }
                    );
                  }else{
                    return Center(child: SizedBox());
                  }
                },
              ),
          ),
          Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("admin").snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              var latitude = double.parse(snapshot.data!.docs[index]["latitude"]);
                              var longitude = double.parse(snapshot.data!.docs[index]["longitude"]);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMapPage(
                                latitude: latitude,
                                longitude: longitude,
                                departmentName: snapshot.data!.docs[index]["type"],
                              )));
                            },
                            child: Card(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: ListTile(
                                title: Text("${snapshot.data!.docs[index]["type"]}",style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                ),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                              ),
                            ),
                          );
                        }
                    );
                  }else{
                    return Center(child: SizedBox());
                  }
                },
              ),
          ),
          Expanded(
            flex: 3,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("library").snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              var latitude = double.parse(snapshot.data!.docs[index]["latitude"]);
                              var longitude = double.parse(snapshot.data!.docs[index]["longitude"]);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMapPage(
                                latitude: latitude,
                                longitude: longitude,
                                departmentName: snapshot.data!.docs[index]["type"],
                              )));
                            },
                            child: Card(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: ListTile(
                                title: Text("${snapshot.data!.docs[index]["type"]}",style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                ),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                              ),
                            ),
                          );
                        }
                    );
                  }else{
                    return Center(child: SizedBox());
                  }
                },
              ),
          ),
        ],
      ),
    );
  }
}
