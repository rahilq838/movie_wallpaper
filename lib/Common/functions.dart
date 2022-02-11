import 'package:flutter/material.dart';
import 'package:movie_wallpaper/Common/theme_colors.dart';

TextStyle getNormalTxtStyle() =>
    const TextStyle(color: txtClr, fontSize: 15, fontWeight: FontWeight.normal);

TextStyle getHeaderTxtStyle() =>
    const TextStyle(color: txtClr, fontSize: 20, fontWeight: FontWeight.bold);

EdgeInsets getAllPadding(double height) => EdgeInsets.all(height * 0.01);

BorderRadius getAllBorderRadius() =>
    const BorderRadius.all(Radius.circular(10));

BoxDecoration getContainerBoxDecoration() => BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          offset: Offset(2, 2),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
      borderRadius: getAllBorderRadius(),
    );
