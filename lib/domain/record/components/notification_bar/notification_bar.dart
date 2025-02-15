import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pilll/analytics.dart';
import 'package:pilll/components/atoms/color.dart';
import 'package:pilll/domain/demography/demography_page.dart';
import 'package:pilll/domain/premium_introduction/premium_introduction_sheet.dart';
import 'package:pilll/domain/premium_introduction/util/discount_deadline.dart';
import 'package:pilll/domain/premium_trial/premium_trial_complete_modal.dart';
import 'package:pilll/domain/premium_trial/premium_trial_modal.dart';
import 'package:pilll/domain/record/components/notification_bar/components/discount_price_deadline.dart';
import 'package:pilll/domain/record/components/notification_bar/components/ended_pill_sheet.dart';
import 'package:pilll/domain/record/components/notification_bar/notification_bar_store.dart';
import 'package:pilll/domain/record/components/notification_bar/components/premium_trial_guide.dart';
import 'package:pilll/domain/record/components/notification_bar/components/premium_trial_limit.dart';
import 'package:pilll/domain/record/components/notification_bar/components/recommend_signup.dart';
import 'package:pilll/domain/record/components/notification_bar/components/recommend_signup_premium.dart';
import 'package:pilll/domain/record/components/notification_bar/components/rest_duration.dart';
import 'package:pilll/domain/record/record_page_state.dart';
import 'package:pilll/signin/signin_sheet.dart';
import 'package:pilll/signin/signin_sheet_state.dart';

class NotificationBar extends HookWidget {
  final RecordPageState parameter;

  NotificationBar(this.parameter);
  @override
  Widget build(BuildContext context) {
    final body = _body(context);
    if (body != null) {
      return Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        color: PilllColors.secondary,
        child: body,
      );
    }

    return Container();
  }

  Widget? _body(BuildContext context) {
    final state = useProvider(notificationBarStateProvider(parameter));
    final store = useProvider(notificationBarStoreProvider(parameter));
    if (!state.isPremium) {
      final premiumTrialLimit = state.premiumTrialLimit;
      if (premiumTrialLimit != null) {
        return PremiumTrialLimitNotificationBar(
            premiumTrialLimit: premiumTrialLimit);
      }

      if (state.hasDiscountEntitlement) {
        if (!state.isTrial) {
          final discountEntitlementDeadlineDate =
              state.discountEntitlementDeadlineDate;
          if (discountEntitlementDeadlineDate != null) {
            // NOTE: watch state
            final isOverDiscountDeadline = useProvider(
                isOverDiscountDeadlineProvider(
                    discountEntitlementDeadlineDate));
            if (!isOverDiscountDeadline) {
              return DiscountPriceDeadline(
                  discountEntitlementDeadlineDate:
                      discountEntitlementDeadlineDate,
                  onTap: () {
                    analytics.logEvent(
                        name: "pressed_discount_notification_bar");
                    showPremiumIntroductionSheet(context);
                  });
            }
          }
        }
      }

      final restDurationNotification = state.restDurationNotification;
      if (restDurationNotification != null) {
        return RestDurationNotificationBar(
            restDurationNotification: restDurationNotification);
      }

      if (!state.isLinkedLoginProvider) {
        if (state.totalCountOfActionForTakenPill >= 7) {
          if (!state.recommendedSignupNotificationIsAlreadyShow) {
            return RecommendSignupNotificationBar(
              onTap: () {
                analytics.logEvent(name: "tapped_signup_notification_bar");
                showSigninSheet(
                  context,
                  SigninSheetStateContext.recordPage,
                  (linkAccount) {
                    analytics.logEvent(
                        name: "signined_account_from_notification_bar");
                    showDemographyPageIfNeeded(context);
                  },
                );
              },
              onClose: () {
                analytics.logEvent(
                    name: "record_page_signing_notification_closed");
                store.closeRecommendedSignupNotification();
              },
            );
          }
        }
      }

      if (!state.isTrial) {
        if (state.totalCountOfActionForTakenPill >= 14) {
          if (state.trialDeadlineDate == null) {
            if (!state.premiumTrialGuideNotificationIsClosed) {
              return PremiumTrialGuideNotificationBar(
                onTap: () {
                  analytics.logEvent(
                      name: "pressed_trial_guide_notification_bar");
                  showPremiumTrialModal(context, () {
                    showPremiumTrialCompleteModalPreDialog(context);
                  });
                },
                onClose: () {
                  store.closePremiumTrialNotification();
                },
              );
            }
          }
        }
      }
      if (state.latestPillSheetGroup != null &&
          state.latestPillSheetGroup?.activedPillSheet == null) {
        // ピルシートグループが存在していてactivedPillSheetが無い場合はピルシート終了が何かしらの理由がなくなったと見なし終了表示にする
        return EndedPillSheet();
      }
    } else {
      if (state.shownRecommendSignupNotificationForPremium) {
        return RecommendSignupForPremiumNotificationBar();
      }

      final restDurationNotification = state.restDurationNotification;
      if (restDurationNotification != null) {
        return RestDurationNotificationBar(
            restDurationNotification: restDurationNotification);
      }

      if (state.latestPillSheetGroup != null &&
          state.latestPillSheetGroup?.activedPillSheet == null) {
        // ピルシートグループが存在していてactivedPillSheetが無い場合はピルシート終了が何かしらの理由がなくなったと見なし終了表示にする
        return EndedPillSheet();
      }
    }
  }
}
