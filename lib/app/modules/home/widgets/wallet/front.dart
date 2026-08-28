import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/models/pet.entity.dart';
import 'package:idee_pet/app/core/models/profile.entity.dart';
import 'package:idee_pet/app/modules/home/widgets/wallet/data.dart';
import 'package:idee_pet/app/modules/home/widgets/wallet/retangular_image.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/helps/date_time.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class WalletFront extends StatelessWidget {
  final Pet pet;
  final Profile profile;
  final double heightScreen;
  final double widthScreen;
  const WalletFront({
    super.key,
    required this.pet,
    required this.profile,
    required this.heightScreen,
    required this.widthScreen,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Center(
        child: SizedBox(
          height: heightScreen * 0.3534,
          width: widthScreen * 1.2616,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/wallet/front.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: heightScreen * 0.09,
                left: widthScreen * 0.10,
                child: Container(
                  width: widthScreen * 0.280,
                  height: heightScreen * 0.1633,
                  color: AppColors.wallet,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.9,
                    child: RetangularImage(
                      imageUrl: pet.avatarUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: heightScreen * 0.09,
                left: widthScreen * 0.42,
                child: SizedBox(
                  width: widthScreen / 1.25,
                  height: heightScreen * 0.20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widthScreen / 3.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 6,
                          children: [
                            WalletData(title: 'Nome', subtitle: pet.name),
                            WalletData(
                                title: 'Raça',
                                subtitle: pet.breed?.name ?? 'Vira-lata'),
                            WalletData(
                                title: 'Espécie', subtitle: pet.type.label),
                            WalletData(
                                title: 'Data de nascimento',
                                subtitle: formatDayMonthYear(pet.birthDate)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 6,
                            children: [
                              WalletData(
                                  title: 'Peso', subtitle: pet.weight!.label),
                              WalletData(
                                  title: 'Sexo', subtitle: pet.petSex.label),
                              WalletData(title: 'ID', subtitle: pet.id),
                              WalletData(
                                  title: 'Idade', subtitle: pet.getAge()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: heightScreen * 0.2702,
                left: widthScreen / 2 - (widthScreen / 4.1),
                child: SizedBox(
                  width: widthScreen / 1.5,
                  height: heightScreen * 0.0269,
                  child: Center(
                    child: Text(
                      profile.name,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.title(
                        fontSize: 12,
                        color: AppColors.primary,
                      ).style,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
