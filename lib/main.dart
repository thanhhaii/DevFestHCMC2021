import 'package:final_project_devfest/provider/savemoney_provider.dart';
import 'package:final_project_devfest/screen/authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:final_project_devfest/screen/home/home_screen.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SaveMoneyProvider>(
            create: (context) => SaveMoneyProvider(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Color(0xff746bc9),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomePage();
              } else {
                return Login();
              }
            },
          ),
        ),
      );
  }
}