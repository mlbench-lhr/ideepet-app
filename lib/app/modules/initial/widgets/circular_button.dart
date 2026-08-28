import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core.dart';

class CircularButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CircularButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onPressed(),
        customBorder: CircleBorder(),
        child: Center(
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 10,
              ),
            ),
            child: ClipOval(
              child: Container(
                color: AppColors.primary,
                child: Center(
                  child: CustomLogo.logoIconWhite(
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
