import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/models/pet.entity.dart';

class CardDetailsWidget extends StatelessWidget {
  final Pet pet;
  final double? elevation;
  // final void Function() goToEditDetails;
  // final void Function() goToEditSize;
  const CardDetailsWidget({
    super.key,
    required this.pet,
    this.elevation,
    // required this.goToEditDetails,
    // required this.goToEditSize,
  });

  @override
  Widget build(BuildContext context) {
    double sizeImage = MediaQuery.of(context).size.width / 7;
    double height = 102;
    double width = (MediaQuery.of(context).size.width / 3) - 24;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          // onTap: () => goToEditDetails(),
          child: Card(
            elevation: elevation,
            color: AppColors.buttonColor,
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomLogo.homePetHeart(
                        height: 12,
                        width: 12,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '${pet.getAge()} ',
                        style: AppTextStyles.title(fontSize: 14).style,
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  CustomLogo.homeCalendar(
                    height: sizeImage,
                    width: sizeImage,
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          // onTap: () => goToEditSize(),
          child: Card(
            elevation: elevation,
            color: AppColors.buttonColor,
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomLogo.homePetHeart(
                        height: 12,
                        width: 12,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '${pet.size?.label2} ',
                        style: AppTextStyles.title(fontSize: 14).style,
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  if (pet.size != null)
                    SvgPicture.asset(
                      pet.size!.svgPath,
                      width: sizeImage,
                      height: sizeImage,
                    ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          // onTap: () => goToEditDetails(),
          child: Card(
            elevation: elevation,
            color: AppColors.buttonColor,
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomLogo.homePetHeart(
                        height: 12,
                        width: 12,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '${pet.weight?.label} ',
                        style: AppTextStyles.title(fontSize: 14).style,
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  SvgPicture.asset(
                    'assets/home/customWeight.svg',
                    width: sizeImage,
                    height: sizeImage,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
