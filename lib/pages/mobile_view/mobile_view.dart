import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class MobileView extends StatelessWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: QRViewExample());
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),

            // Expanded(
            //   flex: 1,
            //   child: FittedBox(
            //     fit: BoxFit.contain,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: <Widget>[
            //         if (result != null)
            //           Text(
            //               'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
            //         else
            //           const Text('Scan a code'),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             Container(
            //               margin: const EdgeInsets.all(8),
            //               child: ElevatedButton(
            //                   onPressed: () async {
            //                     await controller?.toggleFlash();
            //                     setState(() {});
            //                   },
            //                   child: FutureBuilder(
            //                     future: controller?.getFlashStatus(),
            //                     builder: (context, snapshot) {
            //                       return Text('Flash: ${snapshot.data}');
            //                     },
            //                   )),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.all(8),
            //               child: ElevatedButton(
            //                   onPressed: () async {
            //                     await controller?.flipCamera();
            //                     setState(() {});
            //                   },
            //                   child: FutureBuilder(
            //                     future: controller?.getCameraInfo(),
            //                     builder: (context, snapshot) {
            //                       if (snapshot.data != null) {
            //                         return Text(
            //                             'Camera facing ${describeEnum(snapshot.data!)}');
            //                       } else {
            //                         return const Text('loading');
            //                       }
            //                     },
            //                   )),
            //             )
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             Container(
            //               margin: const EdgeInsets.all(8),
            //               child: ElevatedButton(
            //                 onPressed: () async {
            //                   await controller?.pauseCamera();
            //                 },
            //                 child: const Text('pause',
            //                     style: TextStyle(fontSize: 20)),
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.all(8),
            //               child: ElevatedButton(
            //                 onPressed: () async {
            //                   await controller?.resumeCamera();
            //                 },
            //                 child: const Text('resume',
            //                     style: TextStyle(fontSize: 20)),
            //               ),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
        Positioned(
            bottom: 10,
            //MediaQuery.of(context).size.height * 0.05,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                                  margin: const EdgeInsets.all(8),
                                  child: IconButton(

                                      onPressed: () async {
                                        await controller?.toggleFlash();
                                        setState(() {});
                                      },
                                    icon: const Icon(Icons.lightbulb_outline, color: Colors.white,),
                                      // child: FutureBuilder(
                                      //   future: controller?.getFlashStatus(),
                                      //   builder: (context, snapshot) {
                                      //     return Text('Flash: ${snapshot.data}');
                                      //   },
                                      // ),
                                  ),
                                ),

                    Container(
                      margin: const EdgeInsets.all(8),
                      child: IconButton(

                        onPressed: () async {
                          await controller?.flipCamera();
                          setState(() {});
                        },
                        icon: const Icon(Icons.flip_camera_ios_outlined, color: Colors.white,),
                        // child: FutureBuilder(
                        //   future: controller?.getFlashStatus(),
                        //   builder: (context, snapshot) {
                        //     return Text('Flash: ${snapshot.data}');
                        //   },
                        // ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      print("Button clicked");
                      SnackBar(
                        content: const Text('Yay! A SnackBar!'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                    },
                    child: Text('Hey Joe')),
                ElevatedButton(onPressed: null, child: Text('Hey Joe')),
                SizedBox(
                  width: 200,
                  child: TextFormField(),
                )
              ],
            ))
      ]),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;

    // ?150: 300
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 10,
          borderWidth: 8,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
