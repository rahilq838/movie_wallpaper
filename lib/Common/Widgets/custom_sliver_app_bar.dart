import "package:flutter/material.dart";

import '../theme_colors.dart';

class TopSliverAppBar extends StatelessWidget {
  final String text;
  final double mHeight;
  final Function? onPressedLogout;

  const TopSliverAppBar(
      {Key? key,
        required this.mHeight,
        required this.text,
        this.onPressedLogout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      centerTitle: true,
      title: Text(
        text,
        style: const TextStyle(color: txtClr),
      ),
      elevation: 5,
      expandedHeight: mHeight * 0.08,
      forceElevated: true,
      actions: onPressedLogout != null
          ? [
        Padding(
          padding: EdgeInsetsDirectional.all(mHeight * 0.019),
          child: OutlinedButton(
            //logging out
            onPressed: () {
              onPressedLogout!();
            },

            child: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.black,
            ),
          ),
        ),
      ]
          : [],
    );
  }
}


