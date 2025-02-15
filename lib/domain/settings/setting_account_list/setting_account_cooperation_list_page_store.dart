import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pilll/auth/apple.dart';
import 'package:pilll/auth/boilerplate.dart';
import 'package:pilll/auth/google.dart';
import 'package:pilll/domain/settings/setting_account_list/setting_account_cooperation_list_page_state.dart';
import 'package:pilll/service/auth.dart';
import 'package:pilll/service/user.dart';
import 'package:riverpod/riverpod.dart';

final settingAccountCooperationListProvider = StateNotifierProvider.autoDispose(
  (ref) => SettingAccountCooperationListPageStore(
    ref.watch(userServiceProvider),
    ref.watch(authServiceProvider),
  ),
);

class SettingAccountCooperationListPageStore
    extends StateNotifier<SettingAccountCooperationListState> {
  final UserService _userService;
  final AuthService _authService;
  SettingAccountCooperationListPageStore(this._userService, this._authService)
      : super(SettingAccountCooperationListState(
            user: FirebaseAuth.instance.currentUser)) {
    reset();
  }

  reset() {
    Future(() async {
      state = state.copyWith(
          user: FirebaseAuth.instance.currentUser, exception: null);
    });
    _subscribe();
  }

  StreamSubscription? _authCanceller;
  _subscribe() {
    _authCanceller?.cancel();
    _authCanceller = _authService.subscribe().listen((user) {
      print(
          "watch sign state uid: ${user.uid}, isAnonymous: ${user.isAnonymous}");
      state = state.copyWith(user: user);
    });
  }

  @override
  void dispose() {
    _authCanceller?.cancel();
    super.dispose();
  }

  Future<SigninWithAppleState> linkApple() {
    if (state.isLinkedApple) {
      throw AssertionError("unexpected already linked apple when link");
    }
    return callLinkWithApple(_userService);
  }

  Future<SigninWithGoogleState> linkGoogle() {
    if (state.isLinkedGoogle) {
      throw AssertionError("unexpected already linked google when link");
    }
    return callLinkWithGoogle(_userService);
  }
}
