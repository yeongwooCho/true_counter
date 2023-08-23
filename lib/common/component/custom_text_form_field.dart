import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/text_style.dart';

enum KeyboardType {
  number,
  everything,
}

class CustomTextFormField extends StatelessWidget {
  final String? title;
  final String? buttonText;
  final GestureTapCallback? onPressedButton;
  final KeyboardType keyboardType;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? hintText;
  final int? maxLength;
  final bool? realOnly;

  const CustomTextFormField({
    Key? key,
    this.title,
    this.buttonText,
    this.onPressedButton,
    this.keyboardType = KeyboardType.everything,
    this.onChanged,
    this.obscureText = false,
    this.hintText,
    this.maxLength,
    this.realOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Text(
            title!,
            style: bodyMediumTextStyle,
          ),
        if (title != null) const SizedBox(height: 8.0),
        if (buttonText != null)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  obscureText: obscureText,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: hintText,
                  ),
                  maxLength: maxLength,
                  keyboardType: keyboardType == KeyboardType.number
                      ? TextInputType.number
                      : TextInputType.multiline,
                  inputFormatters: keyboardType == KeyboardType.number
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : [],
                  readOnly: realOnly ?? false,
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
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: hintText,
            ),
            maxLength: maxLength,
            keyboardType: keyboardType == KeyboardType.number
                ? TextInputType.number
                : TextInputType.multiline,
            inputFormatters: keyboardType == KeyboardType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            readOnly: realOnly ?? false,
          ),
      ],
    );
  }
}
