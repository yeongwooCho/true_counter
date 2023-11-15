import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/text_style.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? buttonText;
  final GestureTapCallback? onPressedButton;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? hintText;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final bool realOnly;
  final bool enabled;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final double contentPaddingVertical;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.title,
    this.buttonText,
    this.onPressedButton,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.obscureText = false,
    this.hintText,
    this.suffixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.realOnly = false,
    this.enabled = true,
    required this.onSaved,
    required this.validator,
    this.onEditingComplete,
    this.focusNode,
    this.contentPaddingVertical = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Text(
            title!,
            style: MyTextStyle.bodyTitleBold,
          ),
        if (title != null) const SizedBox(height: 8.0),
        if (buttonText != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  onSaved: onSaved,
                  validator: validator,
                  onEditingComplete: onEditingComplete,
                  focusNode: focusNode,
                  obscureText: obscureText,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: contentPaddingVertical,
                      horizontal: 12.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: hintText,
                    suffixIcon: suffixIcon,
                  ),
                  maxLength: maxLength,
                  maxLines: maxLines,
                  textInputAction: textInputAction,
                  keyboardType: textInputType,
                  inputFormatters: textInputType == TextInputType.number
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : [],
                  readOnly: realOnly,
                  enabled: enabled,
                ),
              ),
              const SizedBox(width: 12.0),
              ElevatedButton(
                onPressed: onPressedButton,
                style: defaultButtonStyle,
                child: Text(buttonText!),
              ),
            ],
          ),
        if (buttonText == null)
          TextFormField(
            controller: controller,
            onSaved: onSaved,
            validator: validator,
            onEditingComplete: onEditingComplete,
            focusNode: focusNode,
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: contentPaddingVertical,
                horizontal: 12.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: hintText,
              suffixIcon: suffixIcon,
            ),
            style: MyTextStyle.descriptionRegular,
            maxLength: maxLength,
            maxLines: maxLines,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            inputFormatters: textInputType == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            readOnly: realOnly,
            enabled: enabled,
          ),
      ],
    );
  }
}
