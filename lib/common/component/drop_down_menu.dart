import 'package:flutter/material.dart';

enum SizeLabel {
  xs('XS'),
  s('S'),
  m('M'),
  l('L'),
  xl('XL');

  const SizeLabel(this.label);

  final String label;
}

class DropdownMenuWidget extends StatefulWidget {
  final bool isSize;
  final ValueChanged<SizeLabel?> onSelectedSize;
  final ValueChanged<String?> onSelectedAmount;
  final SizeLabel? selectedSize;
  final String? selectedAmount;

  const DropdownMenuWidget({
    super.key,
    required this.isSize,
    required this.onSelectedSize,
    required this.onSelectedAmount,
    this.selectedSize,
    this.selectedAmount,
  });

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<SizeLabel>> sizeEntries =
    <DropdownMenuEntry<SizeLabel>>[];
    for (final SizeLabel size in SizeLabel.values) {
      sizeEntries.add(
        DropdownMenuEntry<SizeLabel>(
          value: size,
          label: size.label,
        ),
      );
    }

    final List<DropdownMenuEntry<String>> amountEntries =
    <DropdownMenuEntry<String>>[];
    for (int index = 0; index < 31; index++) {
      amountEntries.add(
        DropdownMenuEntry<String>(
          value: '$index',
          label: '$index',
        ),
      );
    }

    final width = MediaQuery.of(context).size.width - 56;
    if (widget.selectedSize == null) {
      sizeController.text = '사이즈 선택';
    }
    if (widget.selectedAmount == null) {
      amountController.text = '수량 선택';
    }

    return widget.isSize
        ? DropdownMenu<SizeLabel>(
      initialSelection: widget.selectedSize,
      menuHeight: 300.0,
      width: width / 2,
      dropdownMenuEntries: sizeEntries,
      controller: sizeController,
      onSelected: widget.onSelectedSize,
    )
        : DropdownMenu<String>(
      initialSelection: widget.selectedAmount ?? '0',
      width: width / 2,
      menuHeight: 300.0,
      dropdownMenuEntries: amountEntries,
      controller: amountController,
      onSelected: widget.onSelectedAmount,
    );
  }
}
