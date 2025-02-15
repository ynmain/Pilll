import 'package:pilll/components/template/setting_pill_sheet_group/pill_sheet_type_add_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilll/domain/initial_setting/pill_sheet_group/initial_setting_pill_sheet_group_pill_sheet_type_select_row.dart';
import 'package:pilll/entity/pill_sheet_type.dart';

class SettingPillSheetGroup extends StatelessWidget {
  const SettingPillSheetGroup({
    Key? key,
    required this.pillSheetTypes,
    required this.onAdd,
    required this.onChange,
    required this.onDelete,
  }) : super(key: key);

  final List<PillSheetType> pillSheetTypes;
  final Function(PillSheetType) onAdd;
  final Function(int, PillSheetType) onChange;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...pillSheetTypes
            .asMap()
            .map((index, pillSheetType) {
              return MapEntry(
                index,
                [
                  SizedBox(height: 16),
                  InitialSettingPillSheetGroupPillSheetTypeSelectRow(
                    index: index,
                    pillSheetType: pillSheetType,
                    onSelect: onChange,
                    onDelete: onDelete,
                  ),
                ],
              );
            })
            .values
            .expand((element) => element)
            .toList(),
        if (pillSheetTypes.length < 6) ...[
          SizedBox(height: 24),
          PillSheetTypeAddButton(
            pillSheetTypes: pillSheetTypes,
            onAdd: (pillSheetType) => onAdd(pillSheetType),
          ),
        ],
        SizedBox(height: 80),
      ],
    );
  }
}
