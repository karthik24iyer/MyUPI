import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/src/objects/barcode_capture.dart';
import 'package:myipu/api/fetch_account.dart';
import 'package:myipu/entity/customer.dart';
import 'package:myipu/page/pin_page.dart';
import 'package:myipu/page/qr_page.dart';
import 'package:myipu/page/review_page.dart';
import 'package:page_transition/page_transition.dart';

import '../util/app_util.dart';

class PayPage extends StatefulWidget {
  const PayPage({Key? key, required this.data}) : super(key: key);

  final BarcodeCapture data;

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {

  final amountController = TextEditingController();
  final notesController = TextEditingController();
  String bankName=const FetchAccount().getCurrentUserDetail().bankName;
  String bankFullName=const FetchAccount().getCurrentUserDetail().bankFullName;
  String accountNo=AppUtil.hideDigits(const FetchAccount().getCurrentUserDetail().accountNo);
  bool isAmtEntered=false;

  @override
  void initState() {
    super.initState();
    callApi();
  }

  void callApi() async {
    String name = (await const FetchAccount().getAccountHolderName('karthik24iyer@pingpay')) ?? '';
    log('api_name=$name');
  }

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
        title: AppUtil.appText('Send Money', Colors.white, 20, false),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: AppUtil.getDecoration(10, Colors.white10.withOpacity(0.08)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUtil.appText('Recipient', Colors.white, 15, true),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.white, size: 40),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppUtil.appText(getPayDetail(widget.data.barcodes[0].rawValue, 'name'), Colors.white, 20, false),
                            AppUtil.appText(getPayDetail(widget.data.barcodes[0].rawValue, 'id'), Colors.white70, 14, false),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    AppUtil.appText('From bank account', Colors.white, 14, false),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/4.0x/icons/$bankName.png', scale: 12),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppUtil.appText(bankFullName, Colors.white, 16, false),
                                AppUtil.appText(accountNo, Colors.white70, 14, false),
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                  },
                                  child: AppUtil.appText('Check balance', Colors.blueAccent, 14, false),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          onTap: () {
                          },
                          child: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 30,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: AppUtil.getDecoration(10, Colors.white10.withOpacity(0.08)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUtil.appText('Amount', Colors.white, 15, true),
                    TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) async {
                        if (value.isNotEmpty) {
                          isAmtEntered=true;
                          log('amt entered');
                          return;
                        }
                        if(value.isEmpty) {
                          isAmtEntered=false;
                        }
                      },
                      textAlignVertical: TextAlignVertical.center,
                      controller: amountController,
                      style: AppUtil.appTextStyle(Colors.white, 18, true),
                      decoration: InputDecoration(
                        errorStyle: AppUtil.appTextStyle(Colors.red, 12, true),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Enter Amount',
                        hintStyle: AppUtil.appTextStyle(Colors.white70, 18, false),
                        //fillColor: Colors.white10.withOpacity(0.08),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                        //prefixIcon: AppUtil.appText('\u20B9', Colors.white, 15, false),
                        prefixIcon: const Icon(IconData(0x20B9, fontFamily: 'MaterialIcons'), color: Colors.white54,),
                        prefixIconConstraints: const BoxConstraints(maxWidth: 20, minHeight: 50),
                        //labelText: 'Username',
                        labelStyle: AppUtil.appTextStyle(Colors.white, 14, true),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    AppUtil.appText('Notes (optional)', Colors.white, 15, true),
                    TextFormField(
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          return;
                        }
                      },
                      textAlignVertical: TextAlignVertical.top,
                      controller: notesController,
                      style: AppUtil.appTextStyle(Colors.white, 18, true),
                      decoration: InputDecoration(
                        errorStyle: AppUtil.appTextStyle(Colors.red, 12, true),
                        filled: true,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Enter Notes',
                        hintStyle: AppUtil.appTextStyle(Colors.white70, 18, false),
                        //fillColor: Colors.white10.withOpacity(0.08),
                        //labelText: 'Username',
                        labelStyle: AppUtil.appTextStyle(Colors.white, 14, true),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                      if(isAmtEntered) {
                        Customer receiver = Customer(id: getPayDetail(widget.data.barcodes[0].rawValue, 'id'), name: getPayDetail(widget.data.barcodes[0].rawValue, 'name'), amt: num.tryParse(amountController.text) ?? 1.00, details: notesController.text);
                        Navigator.push(
                            context,
                            PageTransition(
                              alignment: Alignment.center,
                              curve: Curves.linear,
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 100),
                              //child: PinPage(customer: receiver),
                              child: ReviewPage(customer: receiver),
                            )
                        );
                      }
                    },
                    child: AppUtil.appText('Next', isAmtEntered==true?Colors.white:Colors.grey, 20, false),
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

  String getPayDetail(String? rawValue, String type) {
    //String payId = (rawValue ?? '0?pa=Dummy&pn=0').split('?pa=')[1].split('&pn=')[0];
    final paramsString = (rawValue ?? '').replaceFirst('upi://pay?', '');
    final paramsList = paramsString.split('&');

    String? payDetail;
    String regex = type=='name'?'pn=':'pa=';
    for (final param in paramsList) {
      if (param.startsWith(regex)) {
        payDetail = Uri.decodeComponent(param.substring(3));
      }
    }
    if(type=='name') {
      return (payDetail ?? '').replaceAll('+', ' ');
    }
    return payDetail ?? '';
  }
}
