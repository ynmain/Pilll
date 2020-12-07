import 'package:Pilll/domain/initial_setting/initial_setting_2_page.dart';
import 'package:Pilll/components/organisms/pill/pill_sheet_type_select_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:Pilll/store/initial_setting.dart';
import 'package:flutter/material.dart';

class InitialSetting1Page extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final store = useProvider(initialSettingStoreProvider);
    final state = useProvider(initialSettingStoreProvider.state);
    return PillSheetTypeSelectPage(
      title: "1/4",
      callback: (type) {
        store.modify((model) => model.copyWith(pillSheetType: type));
        Navigator.of(context).push(InitialSetting2PageRoute.route());
      },
      selectedPillSheetType: state.entity.pillSheetType,
    );
  }
}

extension InitialSetting1PageRoute on InitialSetting1Page {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: "InitialSetting1Page"),
      builder: (_) => InitialSetting1Page(),
    );
  }
}