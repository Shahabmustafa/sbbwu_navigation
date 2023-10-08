import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key,this.controller,required this.title,this.keyboardType,this.obscureText=false,this.suffixIcon,this.validator,this.onPress}) : super(key: key);

  String title;
  TextEditingController? controller;
  TextInputType? keyboardType;
  bool obscureText;
  IconData? suffixIcon;
  String? Function(String?)? validator;
  VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        onTapOutside: (event){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        decoration: InputDecoration(
          hintText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          suffixIcon: InkWell(
            onTap: onPress,
              child: Icon(suffixIcon),
          ),
        ),
      ),
    );
  }
}
