import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_details.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class StartInvigilation extends StatefulWidget {
  const StartInvigilation({super.key});

  @override
  State<StartInvigilation> createState() => _StartInvigilationState();
}

class _StartInvigilationState extends State<StartInvigilation> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Scan Successful'),
            content: Text(scanData.code.toString()),
            actions: [
              TextButton(
                child: const Text('Scan Again'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StartInvigilation()),
                  );
                  // controller.resumeCamera();
                },
              ),
              TextButton(
                child: const Text('Continue'),
                onPressed: () {
                  controller.dispose();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => InvigilationDetails()),
                  );
                },
              ),
            ],
          );
        },
      ).then((_) => controller.dispose());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: const Text(
            'Scan QR Code',
            style: TextStyle(
              color: white,
            ),
          ),
          backgroundColor: blue,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: blue,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Center(
                child: Text(
                  'Scan QR Code in Controller Room to get your invigilation details and proceed.',
                  style: TextStyle(
                    color: white,
                    fontSize: fontSmall,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: onQRViewCreated,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                onPressed: () {
                  controller?.dispose();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InvigilationDetails()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Can\'t Scan Code? ',
                      style: TextStyle(fontSize: fontMedium, color: black),
                    ),
                    Text(
                      'Type Code.',
                      style: TextStyle(fontSize: fontMedium, color: orange),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
