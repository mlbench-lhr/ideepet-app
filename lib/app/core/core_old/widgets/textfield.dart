import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labeltext;
  final Color bordercolor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool hidePassword;
  final void Function(String)? onChanged;
  final String? erroText;
  final bool enabled;
  final Color cursorColor;
  final int? maxLines;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final TextStyle? inputStyle;
  final TextStyle? hintStyle;
  final EdgeInsets? padding;
  final Icon? suffixIcon;
  final VoidCallback? onTapOutside;
  final FocusNode? focusNode;

  const AppTextField({
    super.key,
    this.validator,
    required this.controller,
    this.labeltext,
    this.bordercolor = AppColors.primary,
    this.inputFormatters,
    this.keyboardType,
    this.hintText,
    this.hidePassword = false,
    this.onChanged,
    this.erroText,
    this.enabled = true,
    this.cursorColor = AppColors.primary,
    this.maxLines,
    this.textInputAction = TextInputAction.done,
    this.textAlign = TextAlign.start,
    this.inputStyle,
    this.hintStyle,
    this.padding,
    this.suffixIcon,
    this.onTapOutside,
    this.focusNode,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        if (widget.onTapOutside != null) widget.onTapOutside!();
      },
      textAlignVertical: TextAlignVertical.center,
      focusNode: widget.focusNode,
      textAlign: widget.textAlign,
      maxLines: widget.hidePassword ? 1 : widget.maxLines,
      textInputAction: widget.textInputAction,
      enabled: widget.enabled,
      cursorColor: widget.cursorColor,
      onChanged: widget.onChanged,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      style: widget.inputStyle ??
          AppTextStyles.poppinsMedium(
            color: AppColors.fontColorSubtitle,
          ).style,
      keyboardType: widget.keyboardType,
      obscureText: widget.hidePassword ? hide : false,
      decoration: InputDecoration(
        contentPadding: widget.padding,
        fillColor: AppColors.textfield.withValues(alpha: 0.2),
        filled: true,
        error: widget.erroText != null && widget.erroText != ''
            ? Text(
                widget.erroText!,
                style: TextStyle(color: Colors.red[800]),
              )
            : null,
        //errorText: widget.erroText == '' ? null : widget.erroText,
        suffixIcon: widget.suffixIcon ??
            (widget.hidePassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        hide = !hide;
                      });
                    },
                    icon: Icon(
                      hide ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.primary,
                    ))
                : null),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.bordercolor),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.bordercolor),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.bordercolor),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        labelText: widget.labeltext,
        hintStyle: widget.hintStyle ??
            AppTextStyles.poppinsMedium(
              color: AppColors.greyWeak,
              overflow: TextOverflow.visible,
              
            ).style,
        hintText: widget.hintText,
      ),
      validator: widget.validator,
    );
  }
}
