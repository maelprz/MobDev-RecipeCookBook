import 'package:flutter/material.dart';

class LabelPill extends StatelessWidget {
  final String text;
  final IconData? icon;
  final double textSize;
  final double? iconSize;
  final FontWeight? fontWeight;
  final double index;
  final MainAxisAlignment? alignment;
  final Color textColor;

  const LabelPill({
    super.key,
    required this.text,
    this.icon,
    required this.textSize,
    this.fontWeight,
    required this.index,
    this.alignment,
    required this.textColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment ?? MainAxisAlignment.start,
      children: [
        if (index == 1) ...[
          if (icon != null) ...[
            Text(
              text,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: fontWeight ?? FontWeight.bold,
                color: textColor,
              ),
            ),

            Icon(
              icon ?? Icons.label,
              size: iconSize ?? textSize,
              color: textColor,
            ),
          ] else ...[
            Text(
              text,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: fontWeight ?? FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ] else if (index == 2 && icon != null) ...[
          Icon(
            icon ?? Icons.label,
            size: iconSize ?? textSize,
            color: textColor,
          ),
          SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: fontWeight ?? FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ],
    );
  }
}
