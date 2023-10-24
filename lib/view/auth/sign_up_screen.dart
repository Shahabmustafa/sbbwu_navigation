


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbbwu_navigator/utils/app_color.dart';
import 'package:sbbwu_navigator/view_model/auth/auth_controller.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> _obscureConfirmPassword = ValueNotifier<bool>(true);
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);
  @override
  Widget build(BuildContext context) {
    final createAccountController = Provider.of<AuthController>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Image.asset("assets/images/images.jpeg",height: 300,width: 300,),
            SizedBox(
              height: size.height * 0.05,
            ),
            Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    title: "User Name",
                    keyboardType: TextInputType.text,
                    controller: userNameController,
                    validator: (value){
                      if(userNameController.text.isEmpty){
                        return "Please Enter Your Email";
                      }return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustomTextField(
                    title: "Email",
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value){
                      if(emailController.text.isEmpty){
                        return "Please Enter Your Email";
                      }else if(!regExp.hasMatch(emailController.text)){
                        return "Please Enter your Valid Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  ValueListenableBuilder(
                      valueListenable: _obscurePassword,
                      builder: (context,value,child){
                        return CustomTextField(
                          title: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscurePassword.value,
                          suffixIcon: _obscurePassword.value ? Icons.visibility_off : Icons.visibility,
                          controller: passwordController,
                          onPress: (){
                            _obscurePassword.value =! _obscurePassword.value;
                          },
                          validator: (value){
                            if(passwordController.text.isEmpty){
                              return "Please Enter Your Password";
                            }else if(passwordController.text.length < 8){
                              return "Please Enter Password Menimum 8 Digits";
                            }
                            return null;
                          },
                        );
                      }
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  ValueListenableBuilder(
                      valueListenable: _obscureConfirmPassword,
                      builder: (context,value,child){
                        return CustomTextField(
                          title: "Confirm Password",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureConfirmPassword.value,
                          suffixIcon: _obscureConfirmPassword.value ? Icons.visibility_off : Icons.visibility,
                          controller: confirmPasswordController,
                          onPress: (){
                            _obscureConfirmPassword.value =! _obscureConfirmPassword.value;
                          },
                          validator: (value){
                            if(confirmPasswordController.text.isEmpty){
                              return "Please Enter Your Password";
                            }else if(passwordController.text != confirmPasswordController.text){
                              return "Confirm Password is wrong";
                            }return null;
                          },
                        );
                      }
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustomButton(
                    title: "Sign up",
                    height: 50,
                    loading: createAccountController.loading,
                    onTap: (){
                      if(_key.currentState!.validate()){
                        createAccountController.SignUpController(
                            context,
                            emailController.text,
                            passwordController.text,
                            userNameController.text,
                            confirmPasswordController.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(
                  width: size.width * 0.01,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text("Log in",style: TextStyle(fontWeight: FontWeight.bold,color: AppColor.primaryColor),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
