import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'premium_introduction_state.freezed.dart';

@freezed
abstract class PremiumIntroductionState implements _$PremiumIntroductionState {
  PremiumIntroductionState._();
  factory PremiumIntroductionState({
    Offerings? offerings,
    @Default(false) bool isCompletedRestore,
    @Default(false) bool isLoading,
    @Default(false) bool isPremium,
    @Default(false) bool hasLoginProvider,
    @Default(false) bool isTrial,
    @Default(false) bool hasDiscountEntitlement,
    DateTime? beginTrialDate,
    DateTime? discountEntitlementDeadlineDate,
  }) = _PremiumIntroductionState;

  bool get isNotYetLoad => offerings == null;
}
