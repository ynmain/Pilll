import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pilll/analytics.dart';
import 'package:pilll/components/atoms/color.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/domain/root/root.dart';
import 'package:pilll/error/universal_error_page.dart';
import 'package:pilll/global_method_channel.dart';
import 'package:pilll/service/purchase.dart';
import 'package:pilll/util/environment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pilll/app/secret.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

Future<void> entrypoint() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('ja_JP');
  await Firebase.initializeApp();

  if (Environment.isLocal) {
    connectToEmulator();
  }
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return UniversalErrorPage(
      error: details.exception.toString(),
      child: null,
      reload: () {
        rootKey.currentState?.reload();
      },
    );
  };
  // MEMO: FirebaseCrashlytics#recordFlutterError called dumpErrorToConsole in function.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  definedChannel();
  runZonedGuarded(() async {
    runApp(ProviderScope(child: App()));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

Future<void> initializePurchase(String uid) async {
  await Purchases.setDebugLogsEnabled(Environment.isDevelopment);
  await Purchases.setup(Secret.revenueCatPublicAPIKey, appUserId: uid);
  Purchases.addPurchaserInfoUpdateListener(callUpdatePurchaseInfo);
  await syncPurchaseInfo();
}

void connectToEmulator() {
  final domain = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFirestore.instance.settings = Settings(
      persistenceEnabled: false, host: '$domain:8080', sslEnabled: false);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: firebaseAnalytics),
      ],
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          centerTitle: true,
          color: PilllColors.white,
          elevation: 3,
        ),
        primaryColor: PilllColors.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: PilllColors.accent,
        toggleableActiveColor: PilllColors.primary,
        cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
            textTheme: CupertinoTextThemeData(textStyle: FontType.xBigTitle)),
        buttonTheme: ButtonThemeData(
          buttonColor: PilllColors.secondary,
          disabledColor: PilllColors.disable,
          textTheme: ButtonTextTheme.primary,
          colorScheme: ColorScheme.light(
            primary: PilllColors.primary,
          ),
        ),
      ),
      home: ProviderScope(
        child: Root(
          key: rootKey,
        ),
      ),
    );
  }
}
