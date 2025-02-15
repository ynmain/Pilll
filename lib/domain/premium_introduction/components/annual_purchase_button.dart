import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pilll/components/atoms/color.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/components/atoms/text_color.dart';
import 'package:pilll/domain/premium_introduction/components/purchase_buttons_state.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class AnnualPurchaseButton extends StatelessWidget {
  final Package annualPackage;
  final OfferingType offeringType;
  final Function(Package) onTap;

  const AnnualPurchaseButton({
    Key? key,
    required this.annualPackage,
    required this.offeringType,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final monthlyPrice = annualPackage.product.price / 12;
    final monthlyPriceString =
        NumberFormat.simpleCurrency(decimalDigits: 0, name: "JPY")
            .format(monthlyPrice);
    return GestureDetector(
      onTap: () {
        onTap(annualPackage);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(33, 24, 33, 24),
            decoration: BoxDecoration(
              color: PilllColors.blueBackground,
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                width: 2,
                color: PilllColors.secondary,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "年額プラン",
                  style: TextStyle(
                    color: TextColor.main,
                    fontFamily: FontFamily.japanese,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "${annualPackage.product.priceString}/年",
                  style: TextStyle(
                    color: TextColor.main,
                    fontFamily: FontFamily.japanese,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "（$monthlyPriceString/月）",
                  style: TextStyle(
                    color: TextColor.main,
                    fontFamily: FontFamily.japanese,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -11,
            right: 8,
            child: _DiscountBadge(
              offeringType: offeringType,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  final OfferingType offeringType;

  const _DiscountBadge({Key? key, required this.offeringType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: PilllColors.primary,
      ),
      child: Text(
        offeringType == OfferingType.limited ? "通常月額と比べて48％OFF" : "37.5％OFF",
        style: TextColorStyle.white.merge(
          TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
            fontFamily: FontFamily.japanese,
          ),
        ),
      ),
    );
  }
}
