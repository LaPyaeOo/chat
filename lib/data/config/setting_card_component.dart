import 'package:flutter/material.dart';

class SettingCardComponent {
  const SettingCardComponent({
    this.icon,
    required this.label,
    required this.onTap,
    this.trailingWidget,
  });

  final Function()? onTap;
  final String? icon;
  final String label;
  final Widget? trailingWidget;
}
