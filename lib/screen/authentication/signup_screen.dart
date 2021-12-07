import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_screen.dart';

class SignUp extends StatefulWidget{
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool obserText =true;
String username="",password="";
class _SignUpState extends State<SignUp>{
  void registWithGuest() async{
    try{
      var rs = await FirebaseAuth.instance.signInAnonymously();
      print(rs.user!.uid);
    }
    on PlatformException catch(e){
      print(e.message.toString());
    }
  }
  void validation() async{
    final FormState? _form = _formKey.currentState;
    if(_form!.validate()){
      try{
        var rs = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: username,password: password);
        print(rs.user!.uid);
      }
      on PlatformException catch(e){
        print(e.message.toString());
      }
    }
    else {
      print("No");
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Form(
          key:_formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text("Register",style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 400 ,
                  width:double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        validator: (value){
                          if(value!.length<9){
                            return "Phone number must be more 9 number";
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Phone number",
                          hintStyle: TextStyle(
                              color: Colors.black
                          ),
                        ),
                      ),
                      TextFormField(
                        obscureText: obserText,
                        validator: (value){
                          if(value!.length<8){
                            return "Password is too short";
                          }
                        },
                        onChanged: (value){
                          setState(() {
                            password = value;
                          });
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
                            validation();
                          })
                      ),
                      Row(
                        children: [
                          const Text("I have Already An Account!"),
                          GestureDetector(
                            child:const Text("Login",style: TextStyle(color: Colors.cyan),),
                            onTap: (){
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx)=>const Login()
                                  )
                              );
                            },

                          )
                        ],
                      ),
                      Container(
                          height: 45,
                          width: double.infinity,
                          child: RaisedButton(
                              child: const Text("Login with Guest"),color: Colors.blueGrey[400],onPressed: (){
                            validation();
                          })
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

        ),
      )

      ,
    );
  }
}