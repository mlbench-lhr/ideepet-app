import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/core_old/widgets/textfield.dart';

class BottomSheetSelector<T> extends StatefulWidget {
  final Function(T) onSelected;
  final List<T> items;
  final String title;
  final T? selected;
  final String Function(T) displayText; // Função para converter T em String
  final EdgeInsets? padding;

  const BottomSheetSelector({
    super.key,
    required this.onSelected,
    required this.items,
    required this.title,
    required this.selected,
    required this.displayText, // Exemplo: (Breed b) => b.name
    this.padding,
  });

  @override
  State<BottomSheetSelector<T>> createState() => _BottomSheetSelectorState<T>();
}

class _BottomSheetSelectorState<T> extends State<BottomSheetSelector<T>> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      controller.text = widget.displayText(widget.selected as T);
    }
  }

  void _onItemSelected(T value) {
    setState(() {
      controller.text = widget.displayText(value);
    });
    widget.onSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //FocusScope.of(context).nextFocus();
        showGenericSelector<T>(
          context,
          _onItemSelected,
          widget.items,
          widget.title,
          widget.displayText,
        );
      },
      child: AppTextField(
        padding: widget.padding,
        controller: controller,
        bordercolor: Colors.transparent,
        hintText: widget.title,
        enabled: false,
        suffixIcon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.fontColorSubtitle,
        ),
      ),
    );
  }
}

void showGenericSelector<T>(
  BuildContext context,
  Function(T) onSelected,
  List<T> items,
  String title,
  String Function(T) displayText,
) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        constraints: const BoxConstraints(
          maxHeight: 270,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                title,
                style: AppTextStyles.poppinsMedium(
                  color: AppColors.selectColorText,
                  fontSize: 14,
                ).style,
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16)),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        displayText(items[index]),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.poppinsMedium(
                          color: AppColors.greyWeak,
                          fontSize: 14,
                        ).style,
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                      onTap: () {
                        onSelected(items[index]);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
