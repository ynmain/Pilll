import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pilll/analytics.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/components/atoms/text_color.dart';
import 'package:pilll/domain/demography/demography_page.dart';
import 'package:pilll/signin/signin_sheet.dart';
import 'package:pilll/signin/signin_sheet_state.dart';

class RecommendSignupForPremiumNotificationBar extends StatelessWidget {
  const RecommendSignupForPremiumNotificationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 8),
      child: GestureDetector(
        onTap: () => showSigninSheet(
            context, SigninSheetStateContext.recordPage, (linkAccount) {
          analytics.logEvent(name: "tapped_premium_signup_notification_bar");
          showDemographyPageIfNeeded(context);
        }),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "images/alert_24.svg",
                        width: 16,
                        height: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "アカウント登録をしてください",
                        style: TextColorStyle.white
                            .merge(FontType.descriptionBold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "機種変更やスマホ紛失時に、プレミアム機能を引き継げません",
                    style: TextStyle(
                      color: TextColor.white,
                      fontFamily: FontFamily.japanese,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: SvgPicture.asset(
                  "images/arrow_right.svg",
                  color: Colors.white,
                ),
                onPressed: () {},
                iconSize: 24,
                padding: EdgeInsets.all(8),
                alignment: Alignment.centerRight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
