import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:true_counter/common/const/text_style.dart';

enum KeyboardType {
  number,
  everything,
}

class CustomTextFormField extends StatelessWidget {
  final String? title;
  final GestureTapCallback? onPressed;
  final KeyboardType keyboardType;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? hintText;
  final int? maxLength;
  final bool? realOnly;

  const CustomTextFormField({
    Key? key,
    this.title,
    this.onPressed,
    this.keyboardType = KeyboardType.everything,
    this.onChanged,
    this.obscureText = false,
    this.hintText,
    this.maxLength,
    this.realOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null)
          SizedBox(
            width: 120.0,
            child: Text(
              title!,
              style: bodyMediumTextStyle,
            ),
          ),
        if (title != null) const SizedBox(width: 16.0),
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: TextFormField(
              obscureText: obscureText,
              onChanged: onChanged,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
        ),
      ],
    );
  }
}
