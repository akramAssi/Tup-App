import 'package:flutter/cupertino.dart';
import 'package:test_app/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily, Color color,
        FontWeight fontWeight) =>
    TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight);


//regular style
TextStyle getRegularStyle(
        {double fontSize = FontSize.s12, required Color color}) =>
    _getTextStyle(
        fontSize, FontConstants.fontfamily, color, FontWeightManager.regular);
//light style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) =>
    _getTextStyle(
        fontSize, FontConstants.fontfamily, color, FontWeightManager.light);

// medium style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) =>
    _getTextStyle(
        fontSize, FontConstants.fontfamily, color, FontWeightManager.medium);

// SemiBold style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) =>
    _getTextStyle(
        fontSize, FontConstants.fontfamily, color, FontWeightManager.semiBold);

// Bold style
TextStyle getBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) =>
    _getTextStyle(
        fontSize, FontConstants.fontfamily, color, FontWeightManager.bold);
