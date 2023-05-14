import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myipu/api/fetch_account.dart';
import 'package:intl/intl.dart';
import 'package:myipu/page/qr_page.dart';
import 'package:myipu/util/app_util.dart';
import 'package:page_transition/page_transition.dart';

import '../entity/customer.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key, required this.customer}) : super(key: key);

  final Customer customer;

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          highlightColor: Colors.transparent,
          onTap: (){
            Navigator.pushReplacement(
                context,
                PageTransition(
                  alignment: Alignment.center,
                  curve: Curves.linear,
                  type: PageTransitionType.leftToRight,
                  duration: const Duration(milliseconds: 100),
                  child: const QrPage(),
                )
            );
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20,),
        ),
        title: AppUtil.appText('Receipt', Colors.white, 20, false),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Icon(Icons.check_rounded, color: Colors.blue, size: 60,),
                const SizedBox(height: 10),
                AppUtil.appText(widget.customer.name, Colors.white, 18, false),
                const SizedBox(height: 20),
                AppUtil.appText('\u{20B9} ${widget.customer.amt}', Colors.blue, 36, false),
                const SizedBox(height: 20),
                AppUtil.appText('Sent', Colors.blue, 16, false),
                const SizedBox(height: 40),
                const Divider(color: Colors.grey, indent: 30, endIndent: 30,),
                const SizedBox(height: 10),
                SizedBox(
                  width: 320,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppUtil.appText('Date:', Colors.white, 18, false),
                          AppUtil.appText(getCurrentTime(), Colors.white, 18, false),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppUtil.appText('Transaction ID:', Colors.white, 18, false),
                          AppUtil.appText(getTransactionID(), Colors.white, 18, false),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppUtil.appText('Sent from:', Colors.white, 18, false),
                          AppUtil.appText(const FetchAccount().getCurrentUserDetail().bankFullName, Colors.white, 18, false),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppUtil.appText('UPI ID:', Colors.white, 18, false),
                          SizedBox(
                            width: 165,
                            child: AppUtil.appText(widget.customer.id, Colors.white, 18, false),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppUtil.appText('Notes:', Colors.white, 18, false),
                          AppUtil.appText(widget.customer.details ?? 'UPI', Colors.white, 18, false),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.grey, indent: 30, endIndent: 30,),

              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppUtil.appText('Powered by', Colors.white70, 12, false),
              const SizedBox(width: 10),
              Image.asset('assets/4.0x/icons/upi.png', scale: 10,),
            ],
          ),
        ],
      ),
    );
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM y, hh:mm a').format(now).toUpperCase();
    return formattedDate;
  }

  String getTransactionID() {
    Random random = Random();
    String randomNumber = '';
    for (int i = 0; i < 12; i++) {
      randomNumber += random.nextInt(10).toString();
    }
    return randomNumber;
  }
}
