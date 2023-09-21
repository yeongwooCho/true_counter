import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/text_style.dart';

// enum KeyboardType {
//   number,
//   everything,
// }

class CustomTextFormField extends StatelessWidget {
  final String? title;
  final String? buttonText;
  final GestureTapCallback? onPressedButton;
  final TextInputType textInputType;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? hintText;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool realOnly;
  final bool enabled;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;

  const CustomTextFormField({
    Key? key,
    this.title,
    this.buttonText,
    this.onPressedButton,
    this.textInputType = TextInputType.text,
    this.onChanged,
    this.obscureText = false,
    this.hintText,
    this.suffixIcon,
    this.maxLength,
    this.realOnly = false,
    this.enabled = true,
    required this.onSaved,
    required this.validator,
    this.onEditingComplete,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Text(
            title!,
            style: bodyTitleBoldTextStyle,
          ),
        if (title != null) const SizedBox(height: 8.0),
        if (buttonText != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  onSaved: onSaved,
                  validator: validator,
                  onEditingComplete: onEditingComplete,
                  focusNode: focusNode,
                  obscureText: obscureText,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: hintText,
                    suffixIcon: suffixIcon,
                  ),
                  maxLength: maxLength,
                  textInputAction: TextInputAction.done,
                  keyboardType: textInputType,
                  // keyboardType: keyboardType == KeyboardType.number
                  //     ? TextInputType.number
                  //     : TextInputType.multiline,
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
            onSaved: onSaved,
            validator: validator,
            onEditingComplete: onEditingComplete,
            focusNode: focusNode,
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: hintText,
              suffixIcon: suffixIcon,
            ),
            style: descriptionTextStyle,
            maxLength: maxLength,
            textInputAction: TextInputAction.done,
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
