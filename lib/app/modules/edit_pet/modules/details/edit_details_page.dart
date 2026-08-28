import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EditDetailsPage extends GetView<EditPetController> {
  const EditDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
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
                          'Edite informações\ndo seu pet',
                          style: AppTextStyles.title(fontSize: 28).style,
                        ),
                        SizedBox(height: 36),
                        Obx(
                          () {
                            return AppTextField(
                              onTapOutside: () =>
                                  FocusScope.of(context).nextFocus(),
                              controller: controller.petNameController,
                              textInputAction: TextInputAction.next,
                              bordercolor: Colors.transparent,
                              cursorColor: AppColors.primary,
                              hintText: 'Nome',
                              maxLines: 1,
                              erroText: controller.petNameError(),
                              onChanged: (_) =>
                                  controller.validatePetNameField(),
                            );
                          },
                        ),
                        SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () {
                                  return Skeletonizer(
                                    enabled: controller.loadingBreeds(),
                                    child: BottomSheetSelector(
                                      onSelected: controller.selectBreed,
                                      items: controller.breeds,
                                      title: 'Raças',
                                      selected: controller.selectedBreed(),
                                      displayText: (breed) => breed.name,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () {
                                  return BottomSheetSelector(
                                    onSelected: controller.selectSex,
                                    items: PetSex.values,
                                    title: 'Sexo',
                                    selected: controller.selectedSex(),
                                    displayText: (sex) => sex.label,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Obx(
                              () {
                                return Expanded(
                                  child: BottomSheetSelector(
                                    onSelected: controller.selectWeight,
                                    items: controller.listWeights,
                                    title: 'Peso',
                                    displayText: (weight) => weight.label,
                                    selected: controller.selectedWeight(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () {
                                  return AppTextField(
                                    // padding: EdgeInsets.symmetric(vertical: 22),
                                    keyboardType: TextInputType.number,
                                    onTapOutside: () =>
                                        FocusScope.of(context).nextFocus(),
                                    controller:
                                        controller.dateOfBirthController,
                                    textInputAction: TextInputAction.next,
                                    bordercolor: Colors.transparent,
                                    cursorColor: AppColors.primary,
                                    hintText: 'Data de nascimento',
                                    maxLines: 1,
                                    erroText: controller.dateOfBirthError(),
                                    onChanged: (_) =>
                                        controller.validateDateOfBirthField(),
                                    inputFormatters: [DateInputFormatter()],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CardPersonalityWidget(
                          pet: controller.pet,
                          elevation: 0,
                          goToEditPersonality: controller.goToPersonality,
                        ),
                        SizedBox(height: 10),
                        CardFoodWidget(
                          pet: controller.pet,
                          elevation: 0,
                          goToEditFood: controller.goToEditFoodPet,
                        ),
                        // SizedBox(height: 10),
                        // ButtonHealth(
                        //   svgPath: 'assets/edit/find.svg',
                        //   title: 'Transferir Pet',
                        //   action: () => controller.goToTransferPet(),
                        // ),
                        SizedBox(height: 10),
                        ButtonHealth(
                          svgPath: 'assets/edit/bio.svg',
                          title: 'Refazer biometria',
                          action: () => controller.goToBiometry(),
                        ),
                        SizedBox(height: 10),
                        ButtonHealth(
                          svgPath: 'assets/edit/camera.svg',
                          title: 'Alterar imagem',
                          action: () => controller.goToImage(),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      CustomButton.filled(
                        action: controller.detailsComplete()
                            ? () {
                                controller.editDetails();
                              }
                            : null,
                        title: Text(
                          'Salvar',
                          style: AppTextStyles.poppinsSemiBold(
                            color: AppColors.background,
                          ).style,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          DialogApp.showOkCancelDialog(
                            context,
                            'Deseja realmente excluir o pet?',
                            'Após a exclusão, os dados serão perdidos permanentemente.',
                            () {
                              controller.deletePet();
                            },
                          );
                        },
                        child: Text(
                          'Excluir Pet',
                          style: TextStyle(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                            decorationThickness: 1.5,
                          ),
                        ),
                      )
                    ],
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
