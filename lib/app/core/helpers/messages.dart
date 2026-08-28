import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';

showError({final String message = 'Erro desconhecido'}) {
  Get.snackbar('Erro', message, backgroundColor: AppColors.errorColor);
}

showSuccess({final String message = 'Sucesso desconhecido'}) {
  Get.snackbar('Sucesso', message, backgroundColor: AppColors.successColor);
}

showWarning({final String message = 'Atenção desconhecida'}) {
  Get.snackbar('Atenção', message, backgroundColor: AppColors.warningColor);
}

showInfo({final String message = 'Informação desconhecida'}) {
  Get.snackbar('Informação', message, backgroundColor: AppColors.infoColor);
}
