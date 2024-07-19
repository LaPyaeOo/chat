import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/app_color.dart';

class OutlinedTextField extends StatelessWidget {
  OutlinedTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.border,
    this.prefix,
    this.suffix,
    this.onTap,
    this.keyboardType,
    this.isInputEnabled = true,
    this.enabled = true,
    this.onSubmitted,
    this.minLine,
    this.maxLength,
    this.inputFormatters,
    this.obscureText = false,
    this.onTapOutside,
    this.onClickSaveBillerInfo,
    this.focusNode,
    this.initialValue,
    required this.userTyped,
  });

  FocusNode? focusNode;
  bool isInputEnabled;
  bool enabled;
  final TextEditingController? controller;
  String? labelText;
  String? hintText;
  String? errorText;
  InputBorder? border;
  Widget? prefix;
  Widget? suffix;
  int? maxLength;
  void Function()? onTap;
  void Function(String? str)? onSubmitted;
  bool obscureText;
  String? initialValue;
  final Function? onTapOutside;
  int? minLine = 1;
  bool? onClickSaveBillerInfo;
  final TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  final Function(String)? userTyped;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      initialValue: initialValue,
      autovalidateMode: (onClickSaveBillerInfo ?? false)
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      onTap: onTap,
      focusNode: focusNode,
      readOnly: !isInputEnabled,
      enabled: enabled,
      onChanged: userTyped,
      onFieldSubmitted: onSubmitted,
      minLines: minLine,
      maxLength: maxLength ?? 60,
      obscureText: obscureText,
      onTapOutside: onTapOutside != null
          ? (input) {
              onTapOutside!();
            }
          : null,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.4,
                color: AppColor.borderRegular,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
        enabledBorder: border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.4,
                color: AppColor.borderRegular,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
        focusedBorder: border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.4,
                color: AppColor.highlightPrimary,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
        prefixIcon: prefix,
        filled: true,
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        labelText: labelText,
        errorText: errorText,
        hintText: hintText,
        counterText: '',
        labelStyle: TextStyle(
          color: AppColor.foregroundSecondary,
        ),
      ),
    );
  }
}
