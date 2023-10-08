import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_navigator/utils/app_color.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key,this.height,this.width,required this.title,this.onTap,this.loading=false}) : super(key: key);
  double? height;
  double? width;
  String title;
  VoidCallback? onTap;
  bool loading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: loading ? Center(child: CircularProgressIndicator(color: Colors.white,)) :Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
          ),
        ),
      ),
    );
  }
}
