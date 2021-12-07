
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_devfest/model/moneysave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SaveMoneyProvider with ChangeNotifier{
  List<MoneySave> lsMoneySave = [];
  Future<void> getUserDataById() async{
    dynamic currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot snapshot = await FirebaseFirestore.instance.doc(currentUser.uid).collection("MoneySave").get();
    for (var element in snapshot.docs) {

      }
    }
  Future<void> createUserData(MoneySave moneySave) async{
    dynamic currentUser = FirebaseAuth.instance.currentUser;
    dynamic document = await FirebaseFirestore.instance.doc(currentUser.uid).collection("MoneySave").doc();
    try {
      await document.set(moneySave).whenComplete(()=>print("Create Complete"));
    } catch (e) {
      print(e);
    }
  }
  Future<void> updateUserData(MoneySave moneySave, String docId) async{
  dynamic currentUser = FirebaseAuth.instance.currentUser;
  dynamic document = await FirebaseFirestore.instance.doc(currentUser.uid).collection("MoneySave").doc(docId);
  try {
    await document.update(moneySave).whenComplete(()=>print("Create Complete"));
  } catch (e) {
    print(e);
  }
}
static Future<void> deleteUserData(MoneySave moneySave, String docId) async{
  dynamic currentUser = FirebaseAuth.instance.currentUser;
  dynamic document = await FirebaseFirestore.instance.doc(currentUser.uid).collection("MoneySave").doc(docId);
  try {
    await document.delete().whenComplete(()=>print("Create Complete"));
  } catch (e) {
    print(e);
  }
}
}