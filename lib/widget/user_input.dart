import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../theme/colors.dart';
import '../widget_functions/style.dart';

class UserInput extends StatelessWidget {
  const UserInput(
      {Key? key,
      this.alert,
      this.enabled,
      this.initialValue,
      required this.maxLength,
      this.maxLines,
      required this.capitalization,
      this.inputFormatters,
      this.controller,
      required this.hintTitle,
      required this.keyboardType,
      required this.context,
      this.obscureText,
      required this.validator,
      required this.onSaved,
      required this.onChanged,
      this.onFieldSubmitted})
      : super(key: key);
  final bool? alert;
  final bool? enabled;
  final String? initialValue;
  final int? maxLength;
  final int? maxLines;
  final TextCapitalization capitalization;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String hintTitle;
  final TextInputType keyboardType;
  final BuildContext context;
  final bool? obscureText;
  final String? Function(String? p1)? validator;
  final String? Function(String? p1)? onSaved;
  final String? Function(String? p1)? onChanged;
  final String? Function(String? p1)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: alert! ? 5 : 10.0, top: 5, right: alert! ? 5 : 10),
      child: TextFormField(
        enabled: enabled, initialValue: initialValue,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(
              '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')) //to prevent emoji usage
        ],
        maxLength: maxLength,
        maxLines: maxLines,
        // obscureText: true,
        textCapitalization: capitalization,
        controller: controller,
        autocorrect: false,
        enableSuggestions: false,
        autofocus: false,
        decoration: InputDecoration(
          label: DescriptionFont(
            text: hintTitle,
            size: 16,
            color: AppColors.primary,
          ),
          // hintText: hintTitle,
          hintStyle: const TextStyle(
              fontSize: 16, color: Colors.grey, fontStyle: FontStyle.italic),
        ),
        keyboardType: keyboardType,
        validator: validator!,
        onSaved: onSaved,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
