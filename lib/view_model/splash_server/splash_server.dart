import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_navigator/view/Home/home_screen.dart';
import 'package:sbbwu_navigator/view/auth/login_screen.dart';

class SplashServer{
  final auth = FirebaseAuth.instance.currentUser;
  isLogin(BuildContext context){
    if(auth != null){
      Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    }else{
      Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }
}