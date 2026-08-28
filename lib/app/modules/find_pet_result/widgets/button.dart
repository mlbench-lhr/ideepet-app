import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';

class BttnFindOption extends StatelessWidget {
  final String label;
  final void Function() onPress;
  final bool selected;
  const BttnFindOption({
    super.key,
    required this.label,
    required this.onPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return selected ? Colors.white : AppColors.primary;
          }
          return selected ? AppColors.primary : Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return selected ? AppColors.primary : Colors.white;
          }
          return selected ? Colors.white : AppColors.grey;
        }),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
      ),
      onPressed: onPress,
      child: Row(
        children: [
          Text(
            label,
          ),
        ],
      ),
    );
  }
}
