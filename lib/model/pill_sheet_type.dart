import 'package:Pilll/model/pill_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum PillSheetType {
  pillsheet_21,
  pillsheet_28_4,
  pillsheet_28_7,
}

extension PillSheetTypeFunctions on PillSheetType {
  static final String firestoreCollectionPath = "pill_sheet_types";
  static PillSheetType fromRawPath(String rawPath) {
    switch (rawPath) {
      case "21錠タイプ":
        return PillSheetType.pillsheet_21;
      case "28錠タイプ(4錠偽薬)":
        return PillSheetType.pillsheet_28_4;
      case "28錠タイプ(7錠偽薬)":
        return PillSheetType.pillsheet_28_7;
      default:
        assert(false);
        return null;
    }
  }

  String get name {
    switch (this) {
      case PillSheetType.pillsheet_21:
        return "21錠タイプ";
      case PillSheetType.pillsheet_28_4:
        return "28錠タイプ(4錠偽薬)";
      case PillSheetType.pillsheet_28_7:
        return "28錠タイプ(7錠偽薬)";
      default:
        assert(false);
        return null;
    }
  }

  String get rawPath => name;

  List<String> get examples {
    switch (this) {
      case PillSheetType.pillsheet_21:
        return ["・トリキュラー21", "・マーベロン21", "・アンジュ21", "・ルナベルなど"];
      case PillSheetType.pillsheet_28_4:
        return ["・ヤーズなど"];
      case PillSheetType.pillsheet_28_7:
        return ["・トリキュラー28", "・マーベロン28", "・アンジュ28"];
      default:
        assert(false);
        return null;
    }
  }

  SvgPicture get image {
    switch (this) {
      case PillSheetType.pillsheet_21:
        return SvgPicture.asset("images/pillsheet_21.svg");
      case PillSheetType.pillsheet_28_4:
        return SvgPicture.asset("images/pillsheet_28_4.svg");
      case PillSheetType.pillsheet_28_7:
        return SvgPicture.asset("images/pillsheet_28_7.svg");
      default:
        assert(false);
        return null;
    }
  }

  String get firestorePath {
    switch (this) {
      case PillSheetType.pillsheet_21:
        return "pillsheet_21";
      case PillSheetType.pillsheet_28_4:
        return "pillsheet_28_4";
      case PillSheetType.pillsheet_28_7:
        return "pillsheet_28_7";
      default:
        assert(false);
        return null;
    }
  }

  int get totalCount {
    switch (this) {
      case PillSheetType.pillsheet_21:
        return 28;
      case PillSheetType.pillsheet_28_4:
        return 28;
      case PillSheetType.pillsheet_28_7:
        return 28;
      default:
        assert(false);
        return null;
    }
  }

  int get beginingWithoutTakenPeriod {
    switch (this) {
      case PillSheetType.pillsheet_21:
        return 22;
      case PillSheetType.pillsheet_28_4:
        return 25;
      case PillSheetType.pillsheet_28_7:
        return 22;
      default:
        assert(false);
        return null;
    }
  }

  int get dosingPeriod {
    switch (this) {
      case PillSheetType.pillsheet_21:
        return 21;
      case PillSheetType.pillsheet_28_4:
        return 24;
      case PillSheetType.pillsheet_28_7:
        return 21;
      default:
        assert(false);
        return null;
    }
  }

  DocumentReference get documentReference {
    return FirebaseFirestore.instance
        .collection(PillSheetTypeFunctions.firestoreCollectionPath)
        .doc(firestorePath);
  }

  PillSheetTypeInfo get typeInfo => PillSheetTypeInfo(
      pillSheetTypeReferencePath: rawPath,
      totalCount: totalCount,
      dosingPeriod: dosingPeriod);
}
