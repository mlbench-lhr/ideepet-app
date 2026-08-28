import 'package:flutter/material.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';

class HealthHeader extends StatelessWidget {
  const HealthHeader({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CircularImageWidget(
            imageUrl: pet.avatarUrl,
            borderColor: AppColors.buttonColor2,
          )
        ],
      );
}
