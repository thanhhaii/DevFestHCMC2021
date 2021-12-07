import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_devfest/model/moneysave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SaveMoneyProvider with ChangeNotifier {
  List<MoneySave> lsMoneySave = [];

  Future<void> getUserDataById() async {
    dynamic currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .doc("a9TIlX1NeBKPnyrfDeNO")
        .collection("MoneySave")
        .get();
    for (var element in snapshot.docs) {}
  }

  Future<bool> createUserData(MoneySave moneySave) async {
    var result = false;
    try {
      dynamic currentUser = FirebaseAuth.instance.currentUser;
      dynamic document = FirebaseFirestore.instance
          .collection("MoneySave")
          .doc(currentUser.uid);
      Map<String, dynamic> map = {};
      map["title"] = moneySave.title;
      map["money"] = moneySave.money;
      map["isPay"] = moneySave.isPay;
      map["date"] = moneySave.date;
      map["userUID"] = moneySave.userUID;
      await document.set(map).whenComplete(() => {result = true});
    } catch (e) {
      result = false;
    }
    return result;
  }

  Future<void> updateUserData(MoneySave moneySave, String docId) async {
    dynamic currentUser = FirebaseAuth.instance.currentUser;
    // dynamic document = await FirebaseFirestore.instance
    //     .doc(currentUser.uid)
    //     .collection("MoneySave")
    //     .doc(docId);
    try {
      Map<String, dynamic> map = json.decode(moneySave.toString());
      // await document
      //     .update(map)
      //     .whenComplete(() => print("Create Complete"));
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteUserData(MoneySave moneySave, String docId) async {
    dynamic currentUser = FirebaseAuth.instance.currentUser;
    dynamic document = await FirebaseFirestore.instance
        .doc(currentUser.uid)
        .collection("MoneySave")
        .doc(docId);
    try {
      await document.delete().whenComplete(() => print("Create Complete"));
    } catch (e) {
      print(e);
    }
  }
}
