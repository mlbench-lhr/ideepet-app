import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class LoadingFindPet extends StatelessWidget {
  final RxDouble progress;
  const LoadingFindPet({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  'Aguarde, estamos procurando o seu Pet...',
                  style: AppTextStyles.subtitle().style,
                ),
              ],
            ))));
  }
}
