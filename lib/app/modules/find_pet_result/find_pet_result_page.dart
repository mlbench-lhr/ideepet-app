import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/modules/find_pet_result/find_pet_result_controller.dart';
import 'package:idee_pet/app/modules/find_pet_result/widgets/button.dart';
import 'package:idee_pet/app/modules/find_pet_result/widgets/find_pet_false.dart';
import 'package:idee_pet/app/modules/find_pet_result/widgets/loading.dart';
import 'package:idee_pet/app/modules/find_pet_result/widgets/sent_data.dart';

class FindPetResultPage extends GetView<FindPetResultController> {
  const FindPetResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading()) {
        return LoadingFindPet(
          progress: controller.progress,
        );
      }

      if (controller.findPet == false) {
        return FindPetFalse(action: controller.back);
      }

      if (controller.findPet == true) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 60, bottom: 40),
              child: Obx(() {
                return Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                          onPressed: () => controller.back(),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Pet encontrado!',
                          style: AppTextStyles.title(fontSize: 24).style,
                        ),
                        RichText(
                          text: TextSpan(
                            style: AppTextStyles.subtitle().style,
                            children: [
                              TextSpan(
                                text: controller.petName,
                                style: AppTextStyles.subtitle().style.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Colors.orange, // ou a cor do seu tema
                                    ),
                              ),
                              const TextSpan(
                                text:
                                    ' foi encontrado e agora vamos ajudar a reunir ele com o dono.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/find_pet/found.svg',
                      ),
                    ),
                    controller.loadingSent.value
                        ? Center(
                            child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Compartilhar informações?',
                                style: AppTextStyles.title(fontSize: 20).style,
                              ),
                              Text(
                                'Deseja enviar sua localização e seu\ncontato ao tutor do pet?',
                                style: AppTextStyles.subtitle(
                                        color: AppColors.primary, fontSize: 14)
                                    .style,
                              ),
                              const SizedBox(height: 10),
                              BttnFindOption(
                                onPress: () => Get.to(() => SentDataFindPet(
                                      email: controller.email,
                                      name: controller.name,
                                      phone: controller.phone,
                                      acceptTerms: controller.acceptTerms,
                                      onSend: controller.sendData,
                                      errorTerms: controller.errorTerms,
                                      loadingSent: controller.loadingSent,
                                    )),
                                label: 'Sim, enviar',
                                selected: true,
                              ),
                              const SizedBox(height: 10),
                              BttnFindOption(
                                onPress: () => controller.sentOnlyLocation(),
                                label: 'Não, enviar só localização',
                              ),
                              // BttnFindOption(
                              //   onPress: () => Get.to(
                              //       () => SucessFindPet(containsData: true)),
                              //   label: 'Teste',
                              // ),
                            ],
                          ),
                  ],
                );
              }),
            ),
          ),
        );
      }

      return SizedBox();
    });
  }
}
