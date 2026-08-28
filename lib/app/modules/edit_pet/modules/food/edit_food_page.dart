import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class EditFoodPage extends GetView<EditPetController> {
  const EditFoodPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
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
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 2),
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
                        'Qual tipo de comida o seu\npet costuma consumir?',
                        style: AppTextStyles.title(fontSize: 20).style,
                      ),
                      SizedBox(height: 36),
                      Obx(() {
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 18),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.foodOptions.length,
                          itemBuilder: (context, index) {
                            final food = controller.foodOptions[index];

                            return Obx(
                              () {
                                final isSelected = controller.containsString(
                                    controller.selectedFoods, food);

                                return CustomButtonSelect(
                                  title: Row(
                                    children: [
                                      Text(
                                        food,
                                        style: AppTextStyles.poppinsSemiBold(
                                          color: isSelected
                                              ? AppColors.background
                                              : AppColors.primary,
                                        ).style,
                                      ),
                                    ],
                                  ),
                                  select: isSelected,
                                  action: () {
                                    if (isSelected) {
                                      controller.removeFoodInList(food);
                                    } else {
                                      controller.addFoodInList(food);
                                    }
                                  },
                                );
                              },
                            );
                          },
                        );
                      }),
                      SizedBox(height: 18),
                      // Obx(
                      //   () {
                      //     return Column(
                      //       children: controller.selectedFoods
                      //           .where((food) => !PetFood.values
                      //               .map((e) => e.label)
                      //               .contains(food))
                      //           .map((food) {
                      //         return Column(
                      //           children: [
                      //             CustomButtonSelect(
                      //               title: Row(
                      //                 children: [
                      //                   Text(
                      //                     food,
                      //                     style: AppTextStyles.poppinsSemiBold(
                      //                       color: AppColors.background,
                      //                     ).style,
                      //                   ),
                      //                 ],
                      //               ),
                      //               select:
                      //                   true, // Como já é um alimento customizado, sempre estará selecionado
                      //               action: () {
                      //                 controller.removeFoodInList(food);
                      //               },
                      //             ),
                      //             SizedBox(
                      //                 height: 18), // Separação entre os itens
                      //           ],
                      //         );
                      //       }).toList(),
                      //     );
                      //   },
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () {
                                return AppTextField(
                                  controller: controller.petFoodController,
                                  textInputAction: TextInputAction.done,
                                  bordercolor: Colors.transparent,
                                  cursorColor: AppColors.primary,
                                  hintText: 'Outro',
                                  maxLines: 1,
                                  erroText: controller.petFoodError(),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            icon: Icon(Icons.add, color: AppColors.primary),
                            onPressed: () {
                              controller.addCustomFood();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () {
                  return CustomButton.filled(
                    action: controller.foodComplete
                        ? () => controller.editFood()
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
      ),
    );
  }
}
