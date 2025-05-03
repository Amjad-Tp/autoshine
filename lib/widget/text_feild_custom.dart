import 'package:autoshine/controller/address_add_controller.dart';
import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFeildCustom extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextCapitalization? capitalization;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? prefixText;
  const TextFeildCustom({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.capitalization,
    this.keyboardType,
    this.maxLength,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: goldenYellow,
      validator: validator,
      controller: controller,
      style: TextStyle(fontSize: 14),
      textCapitalization: capitalization ?? TextCapitalization.none,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLength: maxLength,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        labelText: labelText,
        labelStyle: TextStyle(
          color: blackColor.withValues(alpha: .7),
          fontSize: 15,
        ),
        prefixText: prefixText,
        prefixStyle: TextStyle(
          color: blackColor,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: goldenYellow, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: goldenYellow),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

DropdownButtonFormField<String> dropDown(
  AddressAddController controller,
  List<String> dropdownItems,
) {
  return DropdownButtonFormField<String>(
    value:
        controller.selectedAddressType.isEmpty
            ? dropdownItems.first
            : controller.selectedAddressType.value,
    items:
        dropdownItems.map((item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
    onChanged: (value) {
      if (value != null) {
        controller.selectedAddressType.value = value;
      }
    },
    decoration: InputDecoration(
      filled: true,
      fillColor: greyColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: blackColor, width: .5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: blackColor, width: .5),
      ),
    ),
    style: TextStyle(fontWeight: FontWeight.w400, color: blackColor),
    isExpanded: true,
  );
}
