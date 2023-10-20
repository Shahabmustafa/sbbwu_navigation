import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_navigator/view/Home/home_screen.dart';
import 'package:sbbwu_navigator/widgets/custom_message.dart';

class AuthController with ChangeNotifier{

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('user');

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }



  LoginController(BuildContext context,String email,String password){
    setLoading(true);
   try{
     auth.signInWithEmailAndPassword(
       email: email,
       password: password,
     ).then((value){
       setLoading(false);
       Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
       FlutterToast().flutterToastMessage(context, "Your have Successfully Login");
     }).onError((error, stackTrace){
       setLoading(false);
       FlutterToast().flutterToastMessage(context, error.toString());
     });
   }catch(e){
     setLoading(false);
     FlutterToast().flutterToastMessage(context, e.toString());
   }
  }

  SignUpController(BuildContext context,String email,String password,String userName,String confirmPassword){
    setLoading(true);
    try{
       auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      ).then((value){
        setLoading(false);
        firestore.doc(auth.currentUser!.uid).set({
          "uid" : value.user!.uid,
          "userName" : userName,
          "email" : value.user!.email,
        }).then((value){
          setLoading(false);
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          print("Add Data");
        }).onError((error, stackTrace){
          setLoading(false);
          print("data not add");
        });
        FlutterToast().flutterToastMessage(context, value.toString());
      }).onError((error, stackTrace){
        setLoading(false);
        FlutterToast().flutterToastMessage(context, error.toString());
      });
    }catch(e){
      setLoading(false);
      FlutterToast().flutterToastMessage(context, e.toString());
    }
  }
}