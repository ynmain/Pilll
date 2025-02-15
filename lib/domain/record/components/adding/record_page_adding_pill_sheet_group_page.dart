import 'package:flutter/material.dart';

import 'package:pilll/analytics.dart';
import 'package:pilll/components/template/setting_pill_sheet_group/setting_pill_sheet_group.dart';
import 'package:pilll/components/atoms/buttons.dart';
import 'package:pilll/components/atoms/color.dart';
import 'package:pilll/components/atoms/text_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pilll/domain/record/record_page_store.dart';
import 'package:pilll/entity/pill_sheet_type.dart';

class RecordPageAddingPillSheetGroupPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final store = useProvider(recordPageStoreProvider);
    final state = useProvider(recordPageStoreProvider.state);
    final setting = state.setting;
    if (setting == null) {
      throw FormatException("ピルシートグループの設定が読み込めませんでした");
    }

    return Scaffold(
      backgroundColor: PilllColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "ピルシート追加",
          style: TextStyle(color: TextColor.black),
        ),
        backgroundColor: PilllColors.white,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(
            children: [
              SettingPillSheetGroup(
                pillSheetTypes: setting.pillSheetTypes,
                onAdd: (pillSheetType) {
                  analytics.logEvent(
                      name: "setting_add_pill_sheet_group",
                      parameters: {"pill_sheet_type": pillSheetType.fullName});
                  store.addPillSheetType(pillSheetType, setting);
                },
                onChange: (index, pillSheetType) {
                  analytics.logEvent(
                      name: "setting_change_pill_sheet_group",
                      parameters: {
                        "index": index,
                        "pill_sheet_type": pillSheetType.fullName
                      });
                  store.changePillSheetType(index, pillSheetType, setting);
                },
                onDelete: (index) {
                  analytics.logEvent(
                      name: "setting_delete_pill_sheet_group",
                      parameters: {"index": index});
                  store.removePillSheetType(index, setting);
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: Container(
                    color: PilllColors.background,
                    child: PrimaryButton(
                      text: "追加",
                      onPressed: () async {
                        analytics.logEvent(
                            name: "pressed_add_pill_sheet_group");
                        await store.register(setting);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}

extension RecordPageAddingPillSheetGroupPageRoute
    on RecordPageAddingPillSheetGroupPage {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      settings: RouteSettings(name: "RecordPageAddingPillSheetGroupPage"),
      builder: (_) => RecordPageAddingPillSheetGroupPage(),
    );
  }
}
