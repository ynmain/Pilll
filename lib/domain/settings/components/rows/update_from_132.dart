import 'package:flutter/material.dart';

import 'package:pilll/analytics.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/domain/settings/information_for_before_major_update.dart';
import 'package:pilll/util/shared_preference/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateFrom132Row extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("大型アップデート前の情報", style: FontType.listRow),
      onTap: () {
        analytics.logEvent(name: "did_select_migrate_132", parameters: {});
        SharedPreferences.getInstance().then((storage) {
          final salvagedOldStartTakenDate =
              storage.getString(StringKey.salvagedOldStartTakenDate);
          final salvagedOldLastTakenDate =
              storage.getString(StringKey.salvagedOldLastTakenDate);
          Navigator.of(context).push(InformationForBeforeMigrate132Route.route(
            salvagedOldStartTakenDate: salvagedOldStartTakenDate!,
            salvagedOldLastTakenDate: salvagedOldLastTakenDate!,
          ));
        });
      },
    );
  }
}
