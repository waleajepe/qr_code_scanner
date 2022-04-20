import 'package:card_scanner/pages/result_page.dart';
import 'package:flutter/material.dart';
import 'package:card_scanner/pages/mobile_view/mobile_view.dart';
import 'package:card_scanner/pages/tab_view/tab_view.dart';
import 'package:card_scanner/responsive_layout/responsive_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ResponsiveLayout(mobileView: TabView(), tabView: TabView(),),
    );
  }
}
