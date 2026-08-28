import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class OnboardingRoutes {
  OnboardingRoutes._();

  static const onboarding = '/onboarding';

  static final routes = [
    GetPage(
      name: onboarding,
      page: () => OnboardingPage(),
      binding: OnboardingBindings(),
    ),
  ];
}
