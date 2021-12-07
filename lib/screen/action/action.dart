import 'package:final_project_devfest/components/appbarcomponent.dart';
import 'package:final_project_devfest/model/moneysave.dart';
import 'package:final_project_devfest/provider/savemoney_provider.dart';
import 'package:final_project_devfest/screen/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({Key? key}) : super(key: key);

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  TextEditingController amountOfMoneyTextField = TextEditingController();
  String _type = "expense";
  TextEditingController titleTextField = TextEditingController();
  DateTime timeFocus = DateTime.now();
  TextEditingController dateInput = TextEditingController(
      text: DateFormat("dd-MM-yyyy").format(DateTime.now()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _createAction() async {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      SaveMoneyProvider moneyProvider = SaveMoneyProvider();
      dynamic currentUser = FirebaseAuth.instance.currentUser;
      var moneySave = MoneySave(
          titleTextField.text.toString(),
          double.parse(amountOfMoneyTextField.text.toString()),
          _type == "expense",
          timeFocus,
          currentUser.uid);
      var result = await moneyProvider.createUserData(moneySave);
      if(result){
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Create action success!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }else {
        Fluttertoast.showToast(
            msg: "An error occurred, please try again later!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.title),
                      hintText: "Title",
                    ),
                    validator: (String? title) {
                      if (title!.isEmpty) {
                        return "Please fill title!";
                      }
                    },
                    controller: titleTextField,
                    maxLines: 1,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        validator: (String? money) {
                          if (money!.isEmpty) {
                            return "Please fill amount of money!";
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.attach_money),
                            hintText: "Amount of money"),
                        controller: amountOfMoneyTextField,
                      )),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Radio(
                              value: "expense",
                              groupValue: _type,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _type = newValue!;
                                });
                              }),
                          const Text(
                            "Expense",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      )),
                      Expanded(
                          child: Row(
                        children: [
                          Radio(
                              value: "income",
                              groupValue: _type,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _type = newValue!;
                                });
                              }),
                          const Text(
                            "Income",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ))
                    ],
                  ),
                  TextField(
                    controller: dateInput,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        //icon of text field
                        labelText: "Enter Date" //label text of field
                        ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        timeFocus = pickedDate;
                        String formattedDate =
                            DateFormat("dd-MM-yyyy").format(pickedDate);
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                ],
              )),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("Save"),
                  onPressed: () {
                    _createAction();
                  },
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Action"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
