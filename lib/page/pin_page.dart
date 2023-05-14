import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myipu/api/fetch_account.dart';
import 'package:myipu/entity/customer.dart';
import 'package:myipu/page/summary_page.dart';
import 'package:myipu/util/app_util.dart';
import 'package:page_transition/page_transition.dart';

class PinPage extends StatefulWidget {
  const PinPage({Key? key, required this.customer}) : super(key: key);

  final Customer customer;

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {

  Color pageColor = const Color(0xFF27357e);
  int cursor=0;
  int currentDigit=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 45),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppUtil.appText('${const FetchAccount().getCurrentUserDetail().bankName.toUpperCase()} Bank', Colors.black, 20, true),
                    Image.asset('assets/4.0x/icons/upi.png', scale: 7,),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                color: pageColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppUtil.appText('Sending  \u{20B9} ${widget.customer.amt}', Colors.white, 15, false),
                    Row(
                      children: [
                        AppUtil.appText('To  ${widget.customer.name.substring(0,10)}', Colors.white, 15, false),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                          },
                          child: const Icon(Icons.arrow_drop_down_sharp, size: 25, color: Colors.white,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              AppUtil.appText('ENTER UPI PIN', Colors.grey, 15, true),
              const SizedBox(height: 20),
              getPinField(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_red_eye, color: pageColor, size: 20,),
                  const SizedBox(width: 10),
                  AppUtil.appText('SHOW', pageColor, 15, false),
                ],
              ),
            ],
          ),
          getNumPad(),
        ],
      ),
    );
  }

  Widget getPinField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(int i=0;i<cursor;i++)
          const SizedBox(
            width: 40,
            height: 10,
            child: Icon(Icons.circle_rounded, color: Colors.black, size: 10,),
          ),
        for(int i=cursor;i<4;i++)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 10,
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: i==cursor?Colors.black:Colors.grey,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget getNumPad() {
    return Container(
      //height: 100,
      color: Colors.black12.withOpacity(0.06),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i=1;i<4;i++)
                getNum(i),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i=4;i<7;i++)
                getNum(i),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i=7;i<10;i++)
                getNum(i),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                onTap: () {
                  setState(() {
                    cursor--;
                    if(cursor<0) {
                      cursor=0;
                    }
                    log('cursor=$cursor');
                  });
                },
                child: Icon(Icons.backspace, size: 30, color: pageColor,),
              ),
              ),
              getNum(0),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                          alignment: Alignment.center,
                          curve: Curves.linear,
                          type: PageTransitionType.leftToRight,
                          duration: const Duration(milliseconds: 100),
                          child: SummaryPage(customer: widget.customer,),
                        )
                    );
                  },
                  child: Icon(Icons.check_circle, size: 70, color: pageColor,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getNum(int num) {
    return Expanded(
      child: InkWell(
        radius: 0,
        highlightColor: Colors.grey,
        splashColor: Colors.grey,
        onTap: () {
          setState(() {
            currentDigit=num;
            cursor++;
            if(cursor>4) {
              cursor=4;
            }
            log('cursor=$cursor');
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: AppUtil.appText(num.toString(), pageColor, 40, false),
        ),
      ),
    );
  }

}
