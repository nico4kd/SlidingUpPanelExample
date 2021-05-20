import 'package:flutter/material.dart';

class Palette {
  static const Color cyanMaker = Color(0xFF00AFEF);
  static const Color verdeClaro = Color(0xFF00E5DC);
  static const Color verdeMedio = Color(0xFF01C6DD);
  static const Color grisOscuro = Color(0xFF585858);
  static const Color grisMedioOscuro = Color(0xFF646464);
  static const Color grisMedio = Color(0xFFC4C4C4);
  static const Color grisMedioClaro = Color(0xFFE0E0E0);
  static const Color grisClaro = Color(0xFFE9E9E9);
  static const Color blanco = Color(0xFFFFFFFF);
  static const Color celeste = Color(0xFF01B9DE);

  static const Color cyan = Color(0xFF00A4E0);

  static const Color btnPrimaryPrincipalForeground = blanco;
  static const Color btnPrimaryNoPrincipalForeground = cyan;
  static const Color btnPrimaryPrincipalBackground = cyan;
  static const Color btnPrimaryNoPrincipalBackground = blanco;

  static const Color btnPrimaryForegroundDisabled = Color(0xFFE9E9E9);
  static const Color btnPrimaryBackgroundDisabled = Color(0xFFA8DAEB);

  static const Color btnSecondaryPrincipalForeground = cyan;
  static const Color btnSecondaryNoPrincipalForeground = blanco;
  static const Color btnSecondaryBackground = Colors.transparent;

  static const Color btnSecondaryForegroundDisabled = Color(0xFFA8DAEB);
  static const Color btnSecondaryBackgroundDisabled = Colors.transparent;

  static const Color onBoardingGradientDark = cyan;
  static const Color onBoardingGradientLight = Color(0xFF00CFDC);
  static const Color disableButtonColor = Color(0xFF979797);

  static const BoxDecoration gradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        onBoardingGradientDark,
        onBoardingGradientLight,
      ],
    ),
  );
}
