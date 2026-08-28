import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class HealthRoutes {
  HealthRoutes._();

  static const health = '/health';
  static const healthPlans = '/health/plans';
  static const vaccine = '/health/vaccine';
  static const medicament = '/health/medicaments';
  static const healthCondition = '/health/condition';
  static const medicalRecord = '/health/mdeical-record';

  static final routes = [
    GetPage(
      name: health,
      page: () => HealthPage(),
      binding: HealthBinding(),
    ),
    GetPage(
      name: healthPlans,
      page: () => HealthPlansPage(),
      binding: HealthPlansBinding(),
    ),
    GetPage(
      name: healthCondition,
      page: () => HealthConditionPage(),
      binding: HealthConditionBinding(),
    ),
    GetPage(
      name: vaccine,
      page: () => VaccinePage(),
      binding: VaccineBinding(),
    ),
    GetPage(
      name: medicament,
      page: () => MedicamentPage(),
      binding: MedicamentBinding(),
    ),
    GetPage(
      name: healthCondition,
      page: () => HealthConditionPage(),
      binding: HealthConditionBinding(),
    ),
    GetPage(
      name: medicalRecord,
      page: () => const MedicalRecordPage(),
      binding: MedicalRecordBinding(),
    ),
  ];
}
