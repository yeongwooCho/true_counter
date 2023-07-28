import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:true_counter/common/const/text_style.dart';

enum KeyboardType {
  number,
  everything,
}

class CustomTextFormField extends StatelessWidget {
  final String title;
  final GestureTapCallback? onPressed;
  final KeyboardType keyboardType;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? hintText;
  final int? maxLength;

  const CustomTextFormField({
    Key? key,
    required this.title,
    this.onPressed,
    this.keyboardType = KeyboardType.everything,
    this.onChanged,
    this.obscureText = false,
    this.hintText,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: SizedBox(
            width: 80.0,
            child: Text(
              title,
              style: bodyMediumTextStyle,
            ),
          ),
        ),
        const SizedBox(width: 4.0),
        Expanded(
          child: TextFormField(
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
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
          ),
        ),
      ],
    );
  }
}
