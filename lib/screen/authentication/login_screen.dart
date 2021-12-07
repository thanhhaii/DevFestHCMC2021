import 'package:final_project_devfest/common/validate.dart';
import 'package:final_project_devfest/screen/authentication/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
bool obserText =true;
class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Container(
                  height: 350,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text("Login",style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold
                      )),
                      TextFormField(
                        validator: (value){
                          if(value == ""){
                            return "Please fill email";
                          }else if(!Validate.checkValidate(Validate.emailValidate, value)){
                            return "Email is invalid";
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:"Email",
                            hintStyle: TextStyle(
                              color: Colors.black,
                            )
                        ),
                      ),
                      TextFormField(
                        obscureText: obserText,
                        validator: (value){
                          if(value!.length<8){
                            return "Password is too short";
                          }
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                              color: Colors.black
                          ),
                          suffixIcon: GestureDetector(
                            onTap: (){
                              setState((){
                                obserText = !obserText;
                              });
                            },
                            child: Icon(
                              obserText == true? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: 45,
                          width: double.infinity,
                          child: RaisedButton(
                              child: const Text("Register"),color: Colors.blueGrey[400],onPressed: (){
                          })
                      ),
                      Row(
                        children: [
                          Text("I don't have account!"),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx)=>const SignUp()
                                  )
                              );
                            },
                            child: Text("Sign up here",style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 20
                            ),),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}