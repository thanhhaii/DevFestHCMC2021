import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_devfest/common/utils.dart';
import 'package:final_project_devfest/model/moneysave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class SaveMoneyProvider with ChangeNotifier {
  List<MoneySave> lsMoneySave = [];
  Future<void> getUserDataById() async{
    List<MoneySave> rs = [];
    dynamic currentUser = FirebaseAuth.instance.currentUser;
    dynamic docs = await FirebaseFirestore.instance.collection("MoneySave").doc("tD2uuNwXlLN63kmn6NzvsQttIqL2").get();
    Map map = Map<String, dynamic>.from(docs.data());
    for(int i=0; i<map.length;i++){
      rs.add(MoneySave(map.entries.toList()[i].value["title"], double.parse(map.entries.toList()[i].value["money"]), map.entries.toList()[i].value["isPay"], map.entries.toList()[i].value["date"].toDate(),map.entries.toList()[i].value["userUID"]));
    }
    lsMoneySave = rs;
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
static dynamic setData(List<MoneySave> lsMoneySave){
  Map<DateTime, List<MoneySave>> mapMoneySave = Map();
    for(int i = 0; i< lsMoneySave.length;i++){
      var time =lsMoneySave[i].date;
      List<MoneySave> tempData = [];
      for(int j = 1; j< lsMoneySave.length;j++){
        var item = lsMoneySave[j];
        if(item.date == time){
          tempData.add(item);
          lsMoneySave.remove(j);
        }
        Map<DateTime, List<MoneySave>> map = {time:tempData};
        mapMoneySave.addAll(map);
      }
      return mapMoneySave;

    }
  }

}

