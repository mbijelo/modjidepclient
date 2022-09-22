
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../abg_utils.dart';

List<MessageData> messages = [];

Future<String?> setEnableDisableNotify(bool _enable) async{
  try{
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null)
      return "user == null";
    await FirebaseFirestore.instance.collection("listusers").doc(user.uid).set({
      "enableNotify": _enable,
    }, SetOptions(merge:true));
  }catch(ex){
    return "setEnableNotify " + ex.toString();
  }
  return null;
}

Future<String?> loadMessages() async{
  try{
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null)
      return "not register";

    var querySnapshot = await FirebaseFirestore.instance.collection("messages").where('user', isEqualTo: user.uid).get();
    messages = [];
    for (var result in querySnapshot.docs) {
      dprint("loadMessages");
      dprint(result.data().toString());
      dprint(result.data()["time"].toDate().toString());
      messages.add(MessageData(result.id, result.data()["title"], result.data()["body"], result.data()["time"].toDate().toLocal()));
    }

    messages.sort((a, b) => a.compareTo(b));
    _setToRead(user);

    addStat("notify", querySnapshot.docs.length);

  }catch(ex){
    return "loadMessages " + ex.toString();
  }
  return null;
}

_setToRead(User user){
  FirebaseFirestore.instance.collection("messages").where('user', isEqualTo: user.uid).where('read', isEqualTo: false)
      .get().then((querySnapshot) {
    for (var result in querySnapshot.docs) {
      print(result.data());
      FirebaseFirestore.instance.collection("messages").doc(result.id).set({
        "read": true,
      }, SetOptions(merge:true)).then((value2) {});
    }
  });
}

deleteMessage(MessageData item) async {
  try{
    await FirebaseFirestore.instance.collection("messages").doc(item.id).delete();
    messages.remove(item);
  }catch(ex){
    return "deleteMessage " + ex.toString();
  }
  return null;
}

class MessageData{
  MessageData(this.id, this.title, this.body, this.time);
  final String id;
  final String title;
  final String body;
  final DateTime time;

  int compareTo(MessageData b){
    if (time.isAfter(b.time))
      return -1;
    if (time.isBefore(b.time))
      return 1;
    return 0;
  }
}
