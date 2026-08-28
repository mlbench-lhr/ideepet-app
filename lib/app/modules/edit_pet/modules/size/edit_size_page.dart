import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/modules/edit_pet/edit_pet_controller.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/buttons.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class EditSizePage extends GetView<EditPetController> {
  const EditSizePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                      icon: CircleAvatar(
                        backgroundColor: AppColors.greyWhite,
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.primary,
                        ),
                      ),
                      onPressed: () {
                        controller.navigatorPop();
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Se o seu pet fosse um\nsuper-heroi, qual seria\no tamanho da capa dele?',
                      style: AppTextStyles.title(fontSize: 20).style,
                    ),
                    SizedBox(height: 36),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 18);
                      },
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.availableSizes.length,
                      itemBuilder: (context, index) {
                        final size = controller.availableSizes[index];
                        return Obx(() {
                          return CustomButtonSelect(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  size.label,
                                  style: AppTextStyles.poppinsSemiBold(
                                    color: controller.selectedSize() == size
                                        ? AppColors.background
                                        : AppColors.primary,
                                  ).style,
                                ),
                                SvgPicture.asset(
                                  size.svgPath,
                                  width: 50,
                                  height: 50,
                                ),
                              ],
                            ),
                            select: controller.selectedSize() == size,
                            action: () => controller.selectSize(size),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () {
                return CustomButton.filled(
                  action: controller.selectedSize() != null &&
                          controller.pet.size != controller.selectedSize()
                      ? () {
                          controller.editSize();
                        }
                      : null,
                  title: Text(
                    'Continuar',
                    style: AppTextStyles.poppinsSemiBold(
                      color: AppColors.background,
                    ).style,
                  ),
                );
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
