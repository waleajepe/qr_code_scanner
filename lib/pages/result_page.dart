import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ResultPage extends StatelessWidget {
  Barcode? data;
  ResultPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Data: ${data!.code}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),),
        ),

      ),
    );
  }
}
