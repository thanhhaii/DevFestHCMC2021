
import 'dart:collection';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_devfest/common/utils.dart';
import 'package:final_project_devfest/model/moneysave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class SaveMoneyProvider with ChangeNotifier{
  List<MoneySave> lsMoneySave = [];
  Future<void> getUserDataById() async{
    List<MoneySave> rs = [];
    dynamic currentUser = FirebaseAuth.instance.currentUser;
    dynamic docs = await FirebaseFirestore.instance.collection("MoneySave").doc("a9TIlX1NeBKPnyrfDeNO").get();
    Map map = Map<String, dynamic>.from(docs.data());
    for(int i=0; i<map.length;i++){
      rs.add(MoneySave(map.entries.toList()[i].value["title"], double.parse(map.entries.toList()[i].value["money"]), map.entries.toList()[i].value["isPay"], map.entries.toList()[i].value["date"].toDate(),map.entries.toList()[i].value["userUID"]));
    }
    lsMoneySave = rs;
  }
  Future<void> createUserData(MoneySave moneySave) async{
    dynamic currentUser = FirebaseAuth.instance.currentUser;
    dynamic document = await FirebaseFirestore.instance.collection("MoneySave").doc(currentUser.uid);
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
static dynamic setData(List<MoneySave> lsMoneySave){
    Map mapMoneySave = new Map();
    for(int i = 0; i< lsMoneySave.length;i++){
      var time = lsMoneySave[i].date;
      var tempData = [];
      if (lsMoneySave[i] != null) {
        for(int j = 0; j< lsMoneySave.length;j++){
          var item = lsMoneySave[j];
          if(item.date == time){
            tempData.add(item);
            lsMoneySave.remove(item);
          }
        }
        Map map = {time:tempData};
        return mapMoneySave.addAll(map);
        }
    }
  }


  @override

  List<MoneySave> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<MoneySave> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }
}