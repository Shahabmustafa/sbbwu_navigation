import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sbbwu_navigator/utils/app_color.dart';
import 'package:sbbwu_navigator/view/auth/login_screen.dart';
import 'package:sbbwu_navigator/view/google_map/google_map_screen.dart';
import 'package:sbbwu_navigator/widgets/custom_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String adminEmail = "malaikaiqbal267@gmail.com";
  final auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Department"),
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
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                        color: AppColor.primaryColor,
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
