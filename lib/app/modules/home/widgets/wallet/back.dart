import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/models/profile.entity.dart';
import 'package:idee_pet/app/modules/home/widgets/wallet/data.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class WalletBack extends StatelessWidget {
  final Profile profile;
  final double heightScreen;
  final double widthScreen;
  const WalletBack({
    super.key,
    required this.profile,
    required this.heightScreen,
    required this.widthScreen,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Center(
          child: SizedBox(
        height: heightScreen * 0.3534,
        width: widthScreen * 1.2616,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/wallet/back.png',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: heightScreen * 0.1204,
              left: widthScreen * 0.6009,
              child: SizedBox(
                width: widthScreen / 1.8,
                height: heightScreen * 0.14,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    WalletData(title: 'Nome do tutor', subtitle: profile.name),
                    WalletData(
                        title: 'Endereço',
                        subtitle: (profile.addressStreet ?? '') +
                            (', ${profile.addressNumber}')),
                  ],
                ),
              ),
            ),
            Positioned(
              top: heightScreen * 0.2702,
              left: widthScreen / 2 - (widthScreen / 4.1),
              child: SizedBox(
                width: widthScreen / 1.5,
                height: heightScreen * 0.0269,
                child: Center(
                  child: Text(
                    profile.name,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title(
                      fontSize: 12,
                      color: AppColors.primary,
                    ).style,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );

    // SvgPicture.asset(
    //   'assets/wallet/front.svg',
    //   width: 200,
    //   height: 200,
    // );
  }
}
