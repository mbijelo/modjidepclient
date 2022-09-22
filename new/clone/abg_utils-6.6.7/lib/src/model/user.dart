import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../abg_utils.dart';

class UserData {
  final String id;
  String name;
  final String email;
  final String role;
  final String phone;
  String logoServerPath;
  final bool providerApp;
  String fcb;
  bool visible;

  // register provider
  String providerName;
  String providerAddress;
  String providerDesc;
  String providerLogoLocalFile;
  String providerLogoServerPath;
  List<String> providerCategory;
  List<LatLng> providerWorkArea;
  //

  int unread = 0;
  int all = 0;
  String lastMessage = "";
  DateTime? lastMessageTime;
  List<AddressData> address;

  // ignore: cancel_subscriptions
  StreamSubscription<DocumentSnapshot>? listen;

  UserData({this.id = "", this.name = "", this.role  = "", this.phone = "",
    this.logoServerPath = "", this.providerApp = false, this.email = "", this.fcb = "", required this.address, this.visible = true,
    // register provider
    this.providerName = "", this.providerAddress = "", this.providerDesc = "",
    this.providerLogoLocalFile = "", this.providerLogoServerPath = "",
    this.providerCategory = const [], this.providerWorkArea = const []
  });

  factory UserData.createEmpty(){
    return UserData(address: []);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'role': role,
    'email': email,
    'logoServerPath': logoServerPath,
    'providerApp': providerApp,
    'FCB': fcb,
    'address': address.map((i) => i.toJson()).toList(),
    'visible': visible,
  };

  factory UserData.fromJson(String id, Map<String, dynamic> data){
    List<AddressData> _address = [];
    if (data['address'] != null)
      for (var element in List.from(data['address'])) {
        _address.add(AddressData.fromJson(element));
      }
    List<LatLng> _providerWorkArea = [];
    if (data["providerWorkArea"] != null)
      for (var element in List.from(data['providerWorkArea'])) {
        if (element['lat'] != null && element['lng'] != null)
          _providerWorkArea.add(LatLng(
              element['lat'], element['lng']
          ));
      }
    List<String> _providerCategory = [];
    if (data['providerCategory'] != null)
      for (var element in List.from(data['providerCategory'])) {
        _providerCategory.add(element);
      }
    return UserData(
      id: id,
      name: (data["name"] != null) ? data["name"] : "",
      email: (data["email"] != null) ? data["email"] : "",
      phone: (data["phone"] != null) ? data["phone"] : "",
      role: (data["role"] != null) ? data["role"] : "",
      fcb: (data["FCB"] != null) ? data["FCB"] : "",
      logoServerPath: (data["logoServerPath"] != null) ? data["logoServerPath"] : "",
      providerApp: (data["providerApp"] != null) ? data["providerApp"] : false,
      address: _address,
      visible: (data["visible"] != null) ? data["visible"] : true,
      //
      providerName: (data["providerName"] != null) ? data["providerName"] : "",
      providerAddress: (data["providerAddress"] != null) ? data["providerAddress"] : "",
      providerDesc: (data["providerDesc"] != null) ? data["providerDesc"] : "",
      providerLogoLocalFile: (data["providerLogoLocalFile"] != null) ? data["providerLogoLocalFile"] : "",
      providerLogoServerPath: (data["providerLogoServerPath"] != null) ? data["providerLogoServerPath"] : "",
      providerWorkArea: _providerWorkArea,
      providerCategory: _providerCategory,
    );
  }

  int compareToAll(UserData b){
    return b.all.compareTo(all);
  }
  int compareToUnread(UserData b){
    return b.unread.compareTo(unread);
  }
}
