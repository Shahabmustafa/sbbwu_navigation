import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbbwu_navigator/view/auth/sign_up_screen.dart';
import 'package:sbbwu_navigator/view_model/auth/auth_controller.dart';
import 'package:sbbwu_navigator/widgets/custom_button.dart';

import '../../utils/app_color.dart';
import '../../widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);
  @override
  Widget build(BuildContext context) {
    final authcontroller = Provider.of<AuthController>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/images.jpeg"),
          Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  height: size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){

                        },
                        child: Text(
                            "Forgoten Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                CustomButton(
                  title: "Login",
                  height: 50,
                  loading: authcontroller.loading,
                  onTap: (){
                    if(_key.currentState!.validate()) {
                      authcontroller.LoginController(
                        context,
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(
                width: size.width * 0.01,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,color: AppColor.primaryColor),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
