import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../abg_utils.dart';

/*
  Admin Panel On demand v1
      chat
      send notify
      booking status change

  on demand customer v2
      chat
      next step - booking status
      new booking - to provider

  on demand provider v2
      chat
      booking status change

*/

Future<String?> sendMessage(String _body, String _title, String _toUserId,
    bool _saveToDB, String cloudKey) async { // parent.appSettings.cloudKey

  if (_toUserId.isEmpty)
    return "_toId.isEmpty";

  var querySnapshot = await FirebaseFirestore.instance.collection("listusers").doc(_toUserId).get();
  if (!querySnapshot.exists)
    return "querySnapshot not exists";

  var data = querySnapshot.data();
  if (data == null)
    return "data == null";

  String _to = (data["FCB"]  != null) ? data["FCB"] : "";

  bool _enableNotify = (data["enableNotify"]  != null) ? data["enableNotify"] : true;
  if (!_enableNotify)
    return null;
  List<String> _blockedUsers = [];
  if (data['blockedUsers'] != null)
    for (dynamic key in data['blockedUsers']){
      _blockedUsers.add(key.toString());
    }

  User? user = FirebaseAuth.instance.currentUser;
  if (user == null)
    return "user = null";
  if (_blockedUsers.contains(user.uid))
    return "${user.uid} blocked";

  // for (var item in parent.notifyModel.users)
  //   if (item.id == _toId) {
  //     _to = item.fcb;
  //     break;
  //   }

  if (_to.isEmpty)
    return null;

  var pathFCM = 'https://fcm.googleapis.com/fcm/send';

  String _key = cloudKey;
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': "application/json",
    'Authorization': "key=$_key",
  };

  dprint("Cloud Key cloudKey");



  var body = json.encoder.convert({
    'notification': {
      'body': _body, 'title': _title, 'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'sound': 'default',
      // 'badge': 1
    },
    'priority': 'high',
    'sound': 'default',
    'data': {
      'body': _body, 'title': _title, 'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'sound': 'default', 'chat': !_saveToDB,
      // 'badge': 1
    },
    'to': _to,
  });


  dprint('body: $body');
  var response = await http.post(Uri.parse(pathFCM), headers: requestHeaders, body: body).timeout(const Duration(seconds: 30));

  dprint('Response status: ${response.statusCode}');
  dprint('Response body: ${response.body}');

  // write to db
  if (_saveToDB) {
    try {
      await FirebaseFirestore.instance.collection("messages").add(
          {
            "time": FieldValue.serverTimestamp(),
            "title": _title,
            "body": _body,
            "user": _toUserId,
            "read": false
          });
    } catch (ex) {
      return "sendMessage " + ex.toString();
    }
  }
















  /*
//send message to fjeanlouis

  var too = "fx7vyRUQRBCNUGwnR4DO4-:APA91bFHqK71s1HzEomUI1WC8czWRnsSBAcTz_fEsUoRaiNVjYM58N2-x_thbIUTSEXGwhei-SSiz9eqNel9c_m5D2esH-TvJ1ALWjP-NcqskZNTylxr1RoVvrn4cqAgazapuMDXO0EI";



  var body10 = json.encoder.convert({
    'notification': {
      'body': messageToAdmin, 'title': messageToAdmin, 'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'sound': 'default',
      // 'badge': 1
    },
    'priority': 'high',
    'sound': 'default',
    'data': {
      'body': messageToAdmin, 'title': messageToAdmin, 'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'sound': 'default', 'chat': !_saveToDB,
      // 'badge': 1
    },
    'to': too,
  });


  dprint('body: $body10');
  var response10 = await http.post(Uri.parse(pathFCM), headers: requestHeaders, body: body10).timeout(const Duration(seconds: 30));

  dprint('Response status: ${response10.statusCode}');
  dprint('Response body: ${response10.body}');

  // write to db
  if (_saveToDB) {
    try {
      await FirebaseFirestore.instance.collection("messages").add(
          {
            "time": FieldValue.serverTimestamp(),
            "title": messageToAdmin,
            "body": messageToAdmin,
            "user": "SRbmrirkvvWxcTdU57JDJpYO34I2",
            "read": false
          });
    } catch (exx) {
      return "sendMessage " + exx.toString();
    }
  }







  //send message to cjeanlouis

  var too = "db8haGWxRqyu_iNkGTD3s0:APA91bE6A7AkxnbK0OTMpoXdlCAq5ZgwecyVSv034qH9ojHmeWtX_-nq5KKQBlUyQ8yZOaCYStAIF5gdi13xsf4cY9mSbHTVnzPZGhJ0Og5sZmue5ms1tQxY_MkbJlQQlcTWBvBqFeUb";



   var body11 = json.encoder.convert({
    'notification': {
      'body': messageToAdmin, 'title': messageToAdmin, 'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'sound': 'default',
      // 'badge': 1
    },
    'priority': 'high',
    'sound': 'default',
    'data': {
      'body': messageToAdmin, 'title': messageToAdmin, 'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'sound': 'default', 'chat': !_saveToDB,
      // 'badge': 1
    },
    'to': too,
  });


  dprint('body: $body11');
  var response11 = await http.post(Uri.parse(pathFCM), headers: requestHeaders, body: body11).timeout(const Duration(seconds: 30));

  dprint('Response status: ${response11.statusCode}');
  dprint('Response body: ${response11.body}');

  // write to db
  if (_saveToDB) {
    try {
      await FirebaseFirestore.instance.collection("messages").add(
          {
            "time": FieldValue.serverTimestamp(),
            "title": messageToAdmin,
            "body": messageToAdmin,
            "user": "Rb45fBE9WeX1nYvinDTRnJfMTvz2",
            "read": false
          });
    } catch (exxx) {
      return "sendMessage " + exxx.toString();
    }
  }

*/



}

