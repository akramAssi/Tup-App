import 'package:flutter/material.dart';
import 'package:test_app/presentation/resources/color_manager.dart';

class CustomeTextField extends StatelessWidget {
  CustomeTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.errorText,
  }) : super(key: key) {
    _borderRadius = BorderRadius.circular(13);

    _enableBorder = OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: ColorManager.lightGrey));

    _foucsBorder = OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: ColorManager.primayOpacity70));

    _errorBorder = OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: ColorManager.error));
  }

  final TextEditingController? controller;
  final String? labelText;
  final String? errorText;
  late final BorderRadius _borderRadius;
  late final OutlineInputBorder _enableBorder;

  late final OutlineInputBorder _foucsBorder;

  late final OutlineInputBorder _errorBorder;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        labelStyle: TextStyle(color: ColorManager.lightGrey),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        enabledBorder: _enableBorder,
        focusedBorder: _foucsBorder,
        errorBorder: _errorBorder,
      ),
    );
  }
}
