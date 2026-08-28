import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/modules/transfer_pet/repository/dtos/response/find_tutor_response.dart';

class TilteTutor extends StatelessWidget {
  final FindTutorResponse tutor;

  const TilteTutor({
    super.key,
    required this.tutor,
  });

  @override
  Widget build(BuildContext context) {
    const avatarRadius = 60.0;
    const avatarDiameter = avatarRadius * 2;

    return SizedBox(
      height: avatarDiameter,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: avatarRadius,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      right: 20, top: 6, bottom: 6, left: avatarRadius + 10),
                  decoration: BoxDecoration(
                    color: AppColors.secundary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    tutor.name,
                    style: AppTextStyles.subtitle(fontSize: 14).style,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.only(
                      right: 20, top: 6, bottom: 6, left: avatarRadius + 10),
                  decoration: BoxDecoration(
                    color: AppColors.secundary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    tutor.email,
                    style: AppTextStyles.subtitle(fontSize: 14).style,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          /// Avatar (NA FRENTE)
          Positioned(
            left: 0,
            top: 0,
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundImage:
                  tutor.imageUrl != null && tutor.imageUrl!.isNotEmpty
                      ? NetworkImage(tutor.imageUrl!)
                      : const AssetImage('assets/icon_profile.png')
                          as ImageProvider,
              backgroundColor: Colors.grey.shade200,
            ),
          ),
        ],
      ),
    );
  }
}
