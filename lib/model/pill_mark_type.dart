import 'package:Pilll/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum PillMarkType {
  normal,
  notTaken,
  selected,
  done,
}

extension PillMarkTypeFunctions on PillMarkType {
  SvgPicture image() {
    switch (this) {
      case PillMarkType.normal:
        return null;
      case PillMarkType.notTaken:
        return null;
      case PillMarkType.selected:
        return null;
      case PillMarkType.done:
        return SvgPicture.asset(
          "images/checkmark.svg",
          color: PilllColors.potti,
          width: 11,
          height: 8.5,
        );
      default:
        assert(false);
        return null;
    }
  }

  Color color() {
    switch (this) {
      case PillMarkType.normal:
        return PilllColors.potti;
      case PillMarkType.notTaken:
        return PilllColors.blank;
      case PillMarkType.selected:
        return PilllColors.enable;
      case PillMarkType.done:
        return PilllColors.lightGray;
      default:
        assert(false);
        return null;
    }
  }
}