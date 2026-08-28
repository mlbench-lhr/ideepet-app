import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppStateService extends GetxService {
  final isLogged = false.obs;
  final pet = Pet.empty().obs;
  final profile = Profile.empty().obs;
  final pets = <Pet>[].obs;

  late final PackageInfo _packageInfo;
  final appVersion = ''.obs;
  final appBuildNumber = ''.obs;

  void cleanAllData() {
    isLogged(false);
    pet(Pet.empty());
    profile(Profile.empty());
    pets.clear();
  }

  @override
  Future<void> onReady() async {
    _packageInfo = await PackageInfo.fromPlatform();
    appVersion(_packageInfo.version);
    appBuildNumber(_packageInfo.buildNumber);

    super.onReady();
  }

  final activePageIndex = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String getCurrentRoute() {
    return Get.currentRoute;
  }

  void setProfile(Profile newProfile) {
    profile.value = newProfile;
  }

  void setPet(Pet newPet) {
    pet.value = newPet;
    print('@@@ petId:${pet().id}');
  }
}
