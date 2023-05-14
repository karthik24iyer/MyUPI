import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myipu/page/pay_page.dart';
import 'package:myipu/util/box_container.dart';
import 'package:page_transition/page_transition.dart';

import '../util/app_util.dart';

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {

  MobileScannerController cameraController = MobileScannerController(returnImage: true, autoStart: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            MobileScanner(
              // fit: BoxFit.contain,
              controller: cameraController,
              onDetect: (capture) {
                log('qr: ${capture.barcodes[0].rawValue}');
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                      alignment: Alignment.center,
                      curve: Curves.linear,
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 100),
                      child: PayPage(data: capture),
                    )
                );
                // final List<Barcode> barcodes = capture.barcodes;
                // final Uint8List? image = capture.image;
                // for (final barcode in barcodes) {
                //   log('Barcode found! ${barcode.rawValue}');
                // }
                // showDialog(
                //   context: context,
                //   builder: (context) =>
                //     AlertDialog(
                //       backgroundColor: Colors.black45,
                //       alignment: Alignment.center,
                //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
                //       title: Column(
                //         children: [
                //           AppUtil.appText('Hii !', Colors.white, 18, true),
                //         ],
                //       ),
                //       content: Column(
                //         children: [
                //           for(int i=0;i<barcodes.length;i++)
                //             Container(
                //               child: AppUtil.appText(barcodes[i].rawValue ?? '', Colors.white, 18, true),
                //             )
                //         ],
                //       ),
                //       actions: [
                //         Center(
                //           child: Column(
                //             children: [
                //               InkWell(
                //                 highlightColor: Colors.transparent,
                //                 onTap: (){
                //                   Navigator.of(context).pop();
                //                 },
                //                 child: Container(
                //                   height: 40,
                //                   width: 150,
                //                   alignment: Alignment.center,
                //                   decoration: AppUtil.getDecoration(70, Colors.white),
                //                   child: AppUtil.appText('Ok', Colors.black, 16, true),
                //                 ),
                //               ),
                //               const SizedBox(height: 20),
                //             ],
                //           ),
                //         ),
                //       ],
                //     )
                // );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100,),
                AppUtil.appText('Supports', Colors.white, 15, true),
                //AppUtil.appText('BHIM UPI PAYTM', Colors.white, 20, true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Image.asset('assets/4.0x/icons/bharatqr.png', scale: 12, color: Colors.transparent),
                    //const SizedBox(width: 5),
                    Image.asset('assets/4.0x/icons/bhim-upi.png', scale: 10, color: Colors.white),
                    const SizedBox(width: 15),
                    Column(
                      children: [
                        Image.asset('assets/4.0x/icons/paytm.png', scale: 80, color: Colors.white),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ],
                ),
                AppUtil.appText('& any other QR code', Colors.white, 15, true),
                const SizedBox(height: 70,),
                // Container(
                //   height: 250,
                //   width: 250,
                //   decoration: BoxDecoration(
                //       border: Border.all(color: Colors.white)
                //   ),
                // ),
                //const BoxContainer(),
                Image.asset('assets/4.0x/icons/box.png', scale: 2.7, color: Colors.white),
                const SizedBox(height: 10,),
                AppUtil.appText('Align the QR code to fit inside the frame.', Colors.white, 15, true),
                const SizedBox(height: 120,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(height: 50, width: 50, decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(100),
                        )),
                        IconButton(
                          color: Colors.white,
                          icon: ValueListenableBuilder(
                            valueListenable: cameraController.torchState,
                            builder: (context, state, child) {
                              switch (state) {
                                case TorchState.off:
                                  return const Icon(Icons.flashlight_off_outlined, color: Colors.white, size: 25,);
                                case TorchState.on:
                                  return const Icon(Icons.flashlight_on_outlined, color: Colors.white, size: 25,);
                              }
                            },
                          ),
                          iconSize: 32.0,
                          onPressed: () => cameraController.toggleTorch(),
                        ),
                      ],
                    ),
                    const SizedBox(width: 70),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 50, width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: ValueListenableBuilder(
                            valueListenable: cameraController.cameraFacingState,
                            builder: (context, state, child) {
                              switch (state) {
                                case CameraFacing.front:
                                  return const Icon(Icons.image_not_supported, size: 25,);
                                case CameraFacing.back:
                                  return const Icon(Icons.image, size: 25,);
                              }
                            },
                          ),
                          iconSize: 32.0,
                          onPressed: () => cameraController.switchCamera(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
