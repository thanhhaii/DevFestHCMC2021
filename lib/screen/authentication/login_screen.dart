import 'package:final_project_devfest/common/validate.dart';
import 'package:final_project_devfest/screen/authentication/signup_screen.dart';
import 'package:final_project_devfest/screen/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool obserText = true;

class _LoginState extends State<Login> {
  TextEditingController emailField = TextEditingController();
  TextEditingController passwordField = TextEditingController();

  void _registerWithGuest() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void _login() async {
    try {
      final FormState? _form = _formKey.currentState;
      if (_form!.validate()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailField.text, password: passwordField.text);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "Login failed, please try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text("Login",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold)),
                      TextFormField(
                        validator: (value) {
                          if (value == "") {
                            return "Please fill email";
                          } else if (!Validate.checkValidate(
                              Validate.emailValidate, value)) {
                            return "Email is invalid";
                          }
                        },
                        controller: emailField,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: Colors.black,
                            )),
                      ),
                      TextFormField(
                        controller: passwordField,
                        obscureText: obserText,
                        validator: (value) {
                          if (value!.length < 8) {
                            return "Password is too short";
                          }
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.black),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obserText = !obserText;
                              });
                            },
                            child: Icon(
                              obserText == true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                              child: const Text("Login"),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey[400])),
                              onPressed: () {
                                _login();
                              })),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            const Text("I don't have account!"),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) => const SignUp()));
                              },
                              child: const Text(
                                "Sign up here",
                                style: TextStyle(
                                  color: Colors.cyan,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey[400])),
                              child: const Text("Login with Guest"),
                              onPressed: () {
                                _registerWithGuest();
                              }))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
