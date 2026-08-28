import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';

class HealthPlansListItemTile extends StatelessWidget {
  const HealthPlansListItemTile({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primary,
              width: 1,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.primary,
              fontSize: 16,
            ),
          ),
        ),
      );
}
