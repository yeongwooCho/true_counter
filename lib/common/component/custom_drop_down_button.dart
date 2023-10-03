import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String> dropdownList;
  final String? defaultValue;
  final ValueChanged<String?> onChanged;
  final double menuMaxHeight;

  const CustomDropDownButton({
    Key? key,
    required this.dropdownList,
    required this.defaultValue,
    required this.onChanged,
    this.menuMaxHeight = 300.0,
  }) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: DARK_GREY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton(
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        menuMaxHeight: widget.menuMaxHeight,
        isExpanded: true,
        underline: const SizedBox(height: 1.0),
        style: descriptionTextStyle,
        value: widget.defaultValue,
        items: widget.dropdownList.map((String item) {
          return DropdownMenuItem<String>(
            alignment: Alignment.center,
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: widget.onChanged,
      ),
    );
  }
}
