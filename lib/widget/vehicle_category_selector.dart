import 'package:flutter/material.dart';

Widget vehicleTypeSelector({
  required String type,
  required String selectedType,
  required void Function(String) onSelect,
  required String title,
  required IconData icon,
}) {
  final isSelected = selectedType == type;

  return GestureDetector(
    onTap: () => onSelect(type),
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          children: [
            const SizedBox(width: 15),
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 40,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

//------Button
TextButton button(
  VoidCallback onPressed,
  String name,
  Color borderColor,
  Color backgroundColor,
  Color textColor,
) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: backgroundColor,
      foregroundColor: textColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(13),
      ),
    ),
    child: Text(
      name,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    ),
  );
}
