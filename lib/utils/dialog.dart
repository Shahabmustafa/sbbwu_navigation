
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogHelper{
  static void showProgressBar(BuildContext context){
    showDialog(context: context, builder: (_) => Center(child: CircularProgressIndicator()),);
  }
}