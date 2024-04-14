import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbbwu_navigator/utils/app_color.dart';
import 'package:sbbwu_navigator/view/splash/splash_screen.dart';
import 'package:sbbwu_navigator/view_model/auth/auth_controller.dart';

import 'firebase_options.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          // useMaterial3: true/,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColor.primaryColor,
          ),
          // cardColor: AppColor.primaryColor,
          cardTheme: CardTheme(
            color: AppColor.primaryColor,
          ),
        ),
        home: SplashPage(),
      ),
    );
  }
}
