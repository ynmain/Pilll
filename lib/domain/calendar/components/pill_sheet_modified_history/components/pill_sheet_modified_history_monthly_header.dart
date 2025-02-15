import 'package:flutter/material.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/components/atoms/text_color.dart';
import 'package:pilll/util/formatter/date_time_formatter.dart';

class CalendarPillSheetModifiedHistoryMonthlyHeader extends StatelessWidget {
  final DateTime dateTimeOfMonth;

  const CalendarPillSheetModifiedHistoryMonthlyHeader(
      {Key? key, required this.dateTimeOfMonth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      DateTimeFormatter.jaMonth(dateTimeOfMonth),
      style: TextStyle(
        color: TextColor.main,
        fontFamily: FontFamily.japanese,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
