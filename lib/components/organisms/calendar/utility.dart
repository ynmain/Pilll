import 'package:pilll/components/organisms/calendar/band/calendar_band_model.dart';
import 'package:pilll/domain/calendar/date_range.dart';
import 'package:pilll/entity/menstruation.dart';
import 'package:pilll/entity/pill_sheet.dart';
import 'package:pilll/entity/pill_sheet_type.dart';
import 'package:pilll/entity/setting.dart';
import 'package:pilll/entity/weekday.dart';

List<DateRange> scheduledMenstruationDateRanges(
  PillSheet pillSheet,
  Setting setting,
  List<Menstruation> menstruations,
  int maxPageCount,
) {
  assert(maxPageCount > 0);
  return List.generate(maxPageCount, (pageIndex) {
    final offset = pageIndex * pillSheet.pillSheetType.totalCount;
    final begin = pillSheet.beginingDate.add(
        Duration(days: (setting.pillNumberForFromMenstruation - 1) + offset));
    final end = begin.add(Duration(days: (setting.durationMenstruation - 1)));
    final isContained = menstruations
        .where((element) =>
            element.dateRange.inRange(begin) || element.dateRange.inRange(end))
        .isNotEmpty;
    if (isContained) {
      return null;
    }
    return DateRange(begin, end);
  }).where((element) => element != null).toList().cast();
}

List<DateRange> nextPillSheetDateRanges(
  PillSheet pillSheet,
  int maxPageCount,
) {
  assert(maxPageCount > 0);
  return List.generate(maxPageCount, (pageIndex) {
    final begin = pillSheet.beginingDate.add(
        Duration(days: pillSheet.pillSheetType.totalCount * (pageIndex + 1)));
    final end = begin.add(Duration(days: Weekday.values.length - 1));
    return DateRange(begin, end);
  });
}

int bandLength(
    DateRange range, CalendarBandModel bandModel, bool isLineBreaked) {
  return range
          .union(
            DateRange(
              isLineBreaked ? range.begin : bandModel.begin,
              bandModel.end,
            ),
          )
          .days +
      1;
}

List<CalendarBandModel> buildBandModels(
  PillSheet? pillSheet,
  Setting? setting,
  List<Menstruation> menstruations,
  int maxPageCount,
) {
  assert(maxPageCount > 0);
  return [
    ...menstruations.map((e) => CalendarMenstruationBandModel(e)),
    if (pillSheet != null) ...[
      ...scheduledMenstruationDateRanges(
              pillSheet, setting!, menstruations, maxPageCount)
          .where((bandRange) => menstruations
              .where((menstruation) =>
                  bandRange.inRange(menstruation.beginDate) ||
                  bandRange.inRange(menstruation.endDate))
              .isEmpty)
          .map((range) =>
              CalendarScheduledMenstruationBandModel(range.begin, range.end)),
      ...nextPillSheetDateRanges(pillSheet, maxPageCount).map(
          (range) => CalendarNextPillSheetBandModel(range.begin, range.end))
    ]
  ];
}
