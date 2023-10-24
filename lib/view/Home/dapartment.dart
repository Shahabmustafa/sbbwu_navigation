import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sbbwu_navigator/view/google_map/google_map_screen.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({Key? key}) : super(key: key);

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  String adminEmail = "malaikaiqbal267@gmail.com";
  final auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Department"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("department").snapshots(),
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
                        departmentName: snapshot.data!.docs[index]["departmentName"],
                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2.5),
                      child: Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: ListTile(
                          title: Text("${snapshot.data!.docs[index]["departmentName"]} Department",style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                          ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                        ),
                      ),
                    ),
                  );
                }
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
