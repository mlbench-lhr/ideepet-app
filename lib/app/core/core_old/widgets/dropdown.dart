import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class AppDropdownSearch<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final void Function(T?)? onChanged;
  final String? hintText;
  final bool showSearchBox;
  final DropdownSearchPopupItemBuilder<T>? itemBuilder;

  const AppDropdownSearch({
    super.key,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.hintText,
    this.showSearchBox = true,
    this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      selectedItem: selectedItem,
      onChanged: onChanged,
      items: (String filter, LoadProps? props) => items,
      filterFn: (item, filter) =>
          item.toString().toLowerCase().contains(filter.toLowerCase()),
      popupProps: PopupProps.menu(
        itemBuilder: itemBuilder,
        showSearchBox: showSearchBox,
        constraints: BoxConstraints(
          maxHeight: items.length * 58 + (showSearchBox ? 56.0 : 0),
        ),
      ),
      suffixProps: DropdownSuffixProps(
        dropdownButtonProps: DropdownButtonProps(
          iconOpened: Icon(
            Icons.keyboard_arrow_up,
          ),
          iconClosed: Icon(
            Icons.keyboard_arrow_down,
          ),
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          fillColor: AppColors.textfield.withValues(alpha: 0.2),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 74, 71, 71)),
          ),
          hintText: hintText,
          hintStyle: AppTextStyles.poppinsMedium(
            color: AppColors.greyWeak,
          ).style,
        ),
      ),
    );
  }
}
