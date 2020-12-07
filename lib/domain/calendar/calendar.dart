import 'package:Pilll/domain/calendar/calculator.dart';
import 'package:Pilll/domain/calendar/calendar_band_model.dart';
import 'package:Pilll/domain/calendar/date_range.dart';
import 'package:Pilll/components/molecules/indicator.dart';
import 'package:Pilll/domain/diary/post_diary_page.dart';
import 'package:Pilll/domain/record/weekday_badge.dart';
import 'package:Pilll/util/datetime/date_compare.dart';
import 'package:Pilll/entity/diary.dart';
import 'package:Pilll/entity/weekday.dart';
import 'package:Pilll/service/diary.dart';
import 'package:Pilll/domain/diary/confirm_diary_sheet.dart';
import 'package:Pilll/store/diaries.dart';
import 'package:Pilll/components/atoms/color.dart';
import 'package:Pilll/components/atoms/font.dart';
import 'package:Pilll/components/atoms/text_color.dart';
import 'package:Pilll/util/datetime/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

abstract class CalendarConstants {
  static final int weekdayCount = 7;
  static final double tileHeight = 60;
}

final calendarDiariesProvider = FutureProvider.autoDispose
    .family<List<Diary>, DateTime>((ref, DateTime dateTimeOfMonth) {
  final state = ref.watch(diariesStoreProvider.state);
  if (state.entities.isNotEmpty) {
    return Future.value(state.entities);
  }
  final diaries = ref.watch(diaryServiceProvider);
  return diaries.fetchListForMonth(dateTimeOfMonth);
});

class Calendar extends HookWidget {
  final Calculator calculator;
  final List<CalendarBandModel> bandModels;
  final double horizontalPadding;

  const Calendar({
    Key key,
    @required this.calculator,
    @required this.bandModels,
    @required this.horizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final futureCalendarDiaries =
        useProvider(calendarDiariesProvider(calculator.date));
    return futureCalendarDiaries.when(
      data: (value) {
        return _body(context, value);
      },
      loading: () => Indicator(),
      error: (error, trace) => Indicator(),
    );
  }

  Column _body(BuildContext context, List<Diary> diaries) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
              CalendarConstants.weekdayCount,
              (index) => Expanded(
                    child: WeekdayBadge(
                      weekday: Weekday.values[index],
                    ),
                  )),
        ),
        Divider(height: 1),
        ...List.generate(calculator.lineCount(), (_line) {
          var line = _line + 1;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                children: [
                  Row(
                    children: Weekday.values.map((weekday) {
                      bool isPreviousMonth =
                          weekday.index < calculator.weekdayOffset() &&
                              line == 1;
                      if (isPreviousMonth) {
                        return CalendarDayTile(
                            onTap: null,
                            weekday: weekday,
                            day: calculator
                                .dateTimeForPreviousMonthTile(weekday.index)
                                .day);
                      }
                      int day = (line - 1) * CalendarConstants.weekdayCount +
                          weekday.index -
                          calculator.weekdayOffset() +
                          1;
                      bool isNextMonth = day > calculator.lastDay();
                      if (isNextMonth) {
                        return Expanded(child: Container());
                      }
                      bool isExistDiary = diaries
                          .where((element) => isSameDay(
                              element.date,
                              DateTime(calculator.date.year,
                                  calculator.date.month, day)))
                          .isNotEmpty;
                      return CalendarDayTile(
                        weekday: weekday,
                        day: day,
                        upperWidget: isExistDiary ? _diaryMarkWidget() : null,
                        onTap: () {
                          final date = calculator
                              .dateTimeForFirstDayOfMonth()
                              .add(Duration(days: day - 1));
                          if (date.isAfter(today())) {
                            return;
                          }
                          if (!isExistDiary) {
                            Navigator.of(context)
                                .push(PostDiaryPageRoute.route(date));
                          } else {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => ConfirmDiarySheet(date),
                              backgroundColor: Colors.transparent,
                            );
                          }
                        },
                      );
                    }).toList(),
                  ),
                  ..._bands(context, line)
                ],
              ),
              Divider(height: 1),
            ],
          );
        }),
      ],
    );
  }

  Widget _diaryMarkWidget() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
          color: PilllColors.gray, borderRadius: BorderRadius.circular(4)),
    );
  }

  List<Widget> _bands(BuildContext context, int line) {
    var range = calculator.dateRangeOfLine(line);
    return bandModels
        .map((bandModel) {
          final isInRange =
              range.inRange(bandModel.begin) || range.inRange(bandModel.end);
          if (!isInRange) {
            return null;
          }
          bool isLineBreaked =
              calculator.notInRangeAtLine(line, bandModel.begin);
          int start =
              calculator.offsetForStartPositionAtLine(line, bandModel.begin);

          final length = range
                  .union(DateRange(
                      isLineBreaked ? bandModel.begin : range.begin,
                      bandModel.end))
                  .days +
              1;
          var tileWidth =
              (MediaQuery.of(context).size.width - horizontalPadding * 2) /
                  Weekday.values.length;
          return Positioned(
            left: start.toDouble() * tileWidth,
            width: tileWidth * length,
            bottom: 0,
            height: 15,
            child: CalendarBand(model: bandModel, isLineBreaked: isLineBreaked),
          );
        })
        .where((element) => element != null)
        .toList();
  }
}

class CalendarBand extends StatelessWidget {
  const CalendarBand({
    Key key,
    @required this.model,
    @required this.isLineBreaked,
  }) : super(key: key);

  final CalendarBandModel model;
  final bool isLineBreaked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: model.color),
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Text(isLineBreaked ? "" : model.label,
            style: FontType.sSmallTitle.merge(TextColorStyle.white)),
      ),
    );
  }
}

class CalendarDayTile extends StatelessWidget {
  final int day;
  final Weekday weekday;
  final VoidCallback onTap;

  final Widget upperWidget;
  final Widget lowerWidget;

  const CalendarDayTile(
      {Key key,
      @required this.day,
      @required this.weekday,
      this.upperWidget,
      this.lowerWidget,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: CalendarConstants.tileHeight,
          child: Stack(
            children: <Widget>[
              if (upperWidget != null) ...[
                Positioned.fill(
                  top: 8,
                  child:
                      Align(alignment: Alignment.topCenter, child: upperWidget),
                )
              ],
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "$day",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: onTap == null
                          ? weekday
                              .weekdayColor()
                              .withAlpha((255 * 0.4).floor())
                          : weekday.weekdayColor(),
                    ).merge(FontType.componentTitle),
                  ),
                ),
              ),
              if (lowerWidget != null) ...[
                Positioned.fill(
                  top: 8,
                  child:
                      Align(alignment: Alignment.topCenter, child: lowerWidget),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}