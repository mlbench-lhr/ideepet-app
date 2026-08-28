import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class ButtonHealth extends StatelessWidget {
  final String? svgPath;
  final String title;
  final IconData? iconData;
  final void Function() action;
  final Color? color;
  const ButtonHealth({
    super.key,
    this.svgPath,
    required this.title,
    required this.action,
    this.iconData,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => action(),
      borderRadius: BorderRadius.circular(10),
      child: Card(
          elevation: 1,
          color: color ?? AppColors.buttonColor3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Card(
                        color: AppColors.buttonColor2,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: svgPath != null
                              ? SvgPicture.asset(
                                  svgPath!,
                                  width: 20,
                                  height: 20,
                                )
                              : iconData != null
                                  ? Icon(
                                      iconData,
                                      size: 20,
                                    )
                                  : SizedBox(
                                      width: 20,
                                      height: 20,
                                    ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          title,
                          style: AppTextStyles.montserratSemiBold(
                                  color: AppColors.primary, fontSize: 14)
                              .style,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: AppColors.primary,
                  size: 35,
                )
              ],
            ),
          )

          // ListTile(
          //   leading: Card(
          //     color: AppColors.background,
          //     child: Padding(
          //       padding: const EdgeInsets.all(6),
          //       child: SvgPicture.asset(
          //         svgPath,
          //         width: 20,
          //         height: 20,
          //       ),
          //     ),
          //   ),
          //   title: Text(
          //     title,
          //     style: AppTextStyles.montserratSemiBold(
          //             color: AppColors.primary, fontSize: 14)
          //         .style,
          //   ),
          //   trailing: Icon(
          //     Icons.keyboard_arrow_right_outlined,
          //     color: AppColors.primary,
          //     size: 35,
          //   ),
          //   contentPadding: EdgeInsets.symmetric(
          //     horizontal: 10,
          //   ),
          // ),
          ),
    );
  }
}
