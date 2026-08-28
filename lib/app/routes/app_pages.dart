import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/routes/biometric_routes.dart';
import 'package:idee_pet/app/routes/capture_image_routes.dart';
import 'package:idee_pet/app/routes/find_pet_result_routes.dart';
import 'package:idee_pet/app/routes/find_pet_routes.dart';
import 'package:idee_pet/app/routes/transfer_pet_routes.dart';
import 'package:idee_pet/lib.dart';

class AppPages {
  AppPages._();

  static final routes = [
    ...EditPetRoutes.routes,
    ...CaptureImageRoutes.routes,
    ...BiometricsRoutes.routes,
    ...BiometricRoutes.routes,
    ...NewPetRoutes.routes,
    ...NotificationsRoutes.routes,
    ...HomeRoutes.routes,
    ...LoginRoutes.routes,
    ...HealthRoutes.routes,
    ...SplashRoutes.routes,
    ...InitialRoutes.routes,
    ...OnboardingRoutes.routes,
    ...OtpRoutes.routes,
    // ...ProfileRoutes.routes,
    ...ForgotPasswordRoutes.routes,
    ...NewPasswordRoutes.routes,
    ...NewPasswordSuccessRoutes.routes,
    ...FindPetRoutes.routes,
    ...FindPetResultRoutes.routes,
    ...TransferPetRoutes.routes
  ];
}
