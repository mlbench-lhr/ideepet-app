import 'package:flutter/material.dart';
import 'package:idee_pet/app/app.dart';

class GeneralCard extends StatelessWidget {
  final String? avatarUrl;
  final String petName;
  final String petId;
  final String? phone;
  final void Function() onTap;
  const GeneralCard({
    super.key,
    this.avatarUrl,
    required this.petName,
    required this.petId,
    this.phone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          color: AppColors.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircularImageWidget(
                  imageUrl: avatarUrl,
                  size: 85,
                  borderColor: AppColors.cardColor,
                  onTap: onTap,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(petName,
                            style: AppTextStyles.title(fontSize: 16).style),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Card(
                            color: AppColors.buttonColor2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: SvgsAccountGeneral.calendar(),
                            ),
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'ID: $petId',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Card(
                            color: AppColors.buttonColor2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: SvgsAccountGeneral.tel(),
                            ),
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              formatPhone(phone),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -4,
          left: -4,
          child: SvgsAccountGeneral.recort(),
        ),
      ],
    );
  }
}
