import 'dart:async';

import 'package:Pilll/model/pill_sheet.dart';
import 'package:Pilll/model/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class UserNotFound implements Exception {
  toString() {
    return "user not found";
  }
}

extension UserFirestoreFieldKeys on String {
  static final anonymouseUserID = "anonymouseUserID";
  static final settings = "settings";
  static final pillSheets = "pillSheets";
}

class User extends ChangeNotifier {
  static final path = "users";
  static User _cache;

  final String anonymousUserID;
  String get documentID => anonymousUserID;
  Setting setting;
  PillSheetModel get currentPillSheet => pillSheets.last;
  List<PillSheetModel> pillSheets;

  User._(
      {@required this.anonymousUserID,
      @required this.setting,
      @required this.pillSheets});

  static User _map(Map<String, dynamic> firestoreDocumentData) {
    return User._(
      anonymousUserID:
          firestoreDocumentData[UserFirestoreFieldKeys.anonymouseUserID],
      setting: firestoreDocumentData[UserFirestoreFieldKeys.settings] != null
          ? Setting.fromJson(
              firestoreDocumentData[UserFirestoreFieldKeys.settings],
            )
          : null,
      pillSheets:
          firestoreDocumentData[UserFirestoreFieldKeys.pillSheets] != null
              ? List(firestoreDocumentData[UserFirestoreFieldKeys.pillSheets])
                  .map((value) {
                  return PillSheetModel.fromJson(value);
                })
              : null,
    );
  }

  static User user() {
    if (_cache == null) throw UserNotFound();
    return _cache;
  }

  static Future<User> fetch() {
    if (_cache != null) {
      return Future.value(_cache);
    }
    return FirebaseFirestore.instance
        .collection(User.path)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((document) {
      if (!document.exists) {
        throw UserNotFound();
      }
      var user = User._map(document.data());
      assert(_cache == null);
      _cache = user;
      return user;
    });
  }

  DocumentReference documentReference() {
    return FirebaseFirestore.instance.collection(User.path).doc(documentID);
  }

  static Future<User> create() {
    return FirebaseFirestore.instance
        .collection(User.path)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(
      {
        UserFirestoreFieldKeys.anonymouseUserID:
            FirebaseAuth.instance.currentUser.uid,
      },
    ).then((_) {
      return User.fetch();
    });
  }

  Future<void> deleteCurrentPillSheet() {
    // TODO:
    assert(false);
    return Future.value();
    // return FirebaseFirestore.instance.collection(User.path).doc(documentID).set(
    //   {
    //     UserFirestoreFieldKeys.pillSheets: null,
    //   },
    //   SetOptions(merge: true),
    // ).then((_) => this.pillSheets = null);
  }

  static User watch(BuildContext context) {
    return context.watch();
  }
}

extension UserInterface on User {
  static Future<User> fetchOrCreateUser() {
    return User.fetch().catchError((error) {
      if (error is UserNotFound) {
        return User.create();
      }
      throw FormatException(
          "cause exception when failed fetch and create user for $error");
    });
  }
}
