import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';

class ClubDialogWidget extends StatelessWidget {
  const ClubDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greyWeak.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back, color: AppColors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SizedBox(
              height: heightScreen * 0.61,
              width: widthScreen * 0.7,
              child: SvgPicture.asset(
                'assets/club/club_info.svg',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(height: heightScreen * 0.1),
      ],
    );
  }
}
