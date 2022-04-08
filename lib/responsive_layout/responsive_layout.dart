import 'package:flutter/material.dart';
import 'package:card_scanner/responsive_layout/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileView;
  final Widget tabView;

  //final Widget desktopView;

  const ResponsiveLayout(
      {Key? key,
      //required this.desktopView,
      required this.mobileView,
      required this.tabView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileWidth) {
        return mobileView;
      } else {
        return tabView;
      }
    });
  }
}
