import 'package:flutter/material.dart';
import 'package:myipu/api/fetch_account.dart';
import 'package:myipu/page/pin_page.dart';
import 'package:myipu/page/qr_page.dart';
import 'package:myipu/util/app_util.dart';
import 'package:page_transition/page_transition.dart';

import '../entity/customer.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key, required this.customer}) : super(key: key);

  final Customer customer;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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
        title: AppUtil.appText('Confirm details', Colors.white, 20, false),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 30),
                AppUtil.appText('Recipient', Colors.grey, 14, false),
                const SizedBox(height: 15),
                AppUtil.appText(widget.customer.name, Colors.white, 18, false),
                const SizedBox(height: 5),
                AppUtil.appText(widget.customer.id, Colors.grey, 16, false),
                const SizedBox(height: 25),
                AppUtil.appText('From my account', Colors.grey, 14, false),
                const SizedBox(height: 15),
                AppUtil.appText(const FetchAccount().getCurrentUserDetail().bankFullName, Colors.white, 18, false),
                const SizedBox(height: 5),
                AppUtil.appText(AppUtil.hideDigits(const FetchAccount().getCurrentUserDetail().accountNo), Colors.grey, 14, false),
                const SizedBox(height: 25),
                AppUtil.appText('Amount', Colors.grey, 14, false),
                const SizedBox(height: 15),
                AppUtil.appText('\u{20B9} ${widget.customer.amt}', Colors.blue, 30, false),
                const SizedBox(height: 25),
                AppUtil.appText('Notes', Colors.grey, 14, false),
                const SizedBox(height: 10),
                AppUtil.appText(widget.customer.details ?? 'Verified Merchant', Colors.white, 18, false),
              ],
            )
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppUtil.appText('Powered by', Colors.white70, 12, false),
                  const SizedBox(width: 10),
                  Image.asset('assets/4.0x/icons/upi.png', scale: 10,),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: AppUtil.appText('Cancel', Colors.white, 20, false),
                  ),
                  const SizedBox(width: 75),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            alignment: Alignment.center,
                            curve: Curves.linear,
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 100),
                            //child: PinPage(customer: receiver),
                            child: PinPage(customer: widget.customer),
                          )
                      );
                    },
                    child: AppUtil.appText('Send', Colors.white, 20, false),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
}
