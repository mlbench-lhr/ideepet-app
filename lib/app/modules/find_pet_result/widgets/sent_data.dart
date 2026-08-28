import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/buttons.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/core_old/widgets/textfield.dart';
import 'package:idee_pet/app/core/helpers/field.dart';

class SentDataFindPet extends StatelessWidget {
  final ValidatedField name;
  final ValidatedField phone;
  final ValidatedField email;
  final RxBool acceptTerms;
  final VoidCallback onSend;
  final RxString errorTerms;
  final RxBool loadingSent;
  const SentDataFindPet(
      {super.key,
      required this.name,
      required this.phone,
      required this.email,
      required this.acceptTerms,
      required this.onSend,
      required this.errorTerms,
      required this.loadingSent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 40),
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
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
                    onPressed: () => Get.back(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Seus Dados',
                    style: AppTextStyles.title(fontSize: 26).style,
                  ),
                  Text(
                    'Forneça seus dados de contato.',
                    style: AppTextStyles.subtitle().style,
                  ),
                  const SizedBox(height: 24),
                  Obx(() => AppTextField(
                        controller: name.controller,
                        hintText: 'Nome Completo*',
                        textInputAction: TextInputAction.next,
                        bordercolor: Colors.transparent,
                        cursorColor: AppColors.primary,
                        erroText: name.error.value,
                        onChanged: (_) => name.validate(),
                      )),
                  const SizedBox(height: 24),
                  Obx(() {
                    return AppTextField(
                      controller: phone.controller,
                      hintText: 'Telefone*',
                      textInputAction: TextInputAction.next,
                      bordercolor: Colors.transparent,
                      cursorColor: AppColors.primary,
                      erroText: phone.error.value,
                      onChanged: (value) => phone.validate(),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                    );
                  }),
                  const SizedBox(height: 24),
                  Obx(() {
                    return AppTextField(
                      controller: email.controller,
                      hintText: 'E-mail (opcional)',
                      textInputAction: TextInputAction.next,
                      bordercolor: Colors.transparent,
                      cursorColor: AppColors.primary,
                      erroText: email.error.value,
                      onChanged: (value) => email.validate(),
                    );
                  }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Row(
                            children: [
                              Checkbox(
                                activeColor: AppColors.primary,
                                value: acceptTerms.value,
                                onChanged: (value) {
                                  if (value != null) acceptTerms.value = value;
                                  if (value == true) {
                                    errorTerms.value = '';
                                  }
                                },
                              ),
                              const Text(
                                'Aceito os termos e condições',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          )),
                      Obx(() => errorTerms.value.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                errorTerms.value,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              ),
                            )),
                    ],
                  ),
                  Center(
                    child: Image.asset(
                      'assets/find_pet/pethealth.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ),
                  SizedBox(height: 24),
                  loadingSent.value
                      ? Center(
                          child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomButton.filled(
                              title: Text(
                                'Enviar',
                                style: AppTextStyles.poppinsSemiBold(
                                        fontSize: 20,
                                        color: AppColors.background)
                                    .style,
                              ),
                              action: onSend,
                            ),
                            Center(
                              child: TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColors.selectColorText,
                                        fontSize: 15),
                                  )),
                            ),
                          ],
                        )
                ],
              );
            }),
          ),
        ));
  }
}
