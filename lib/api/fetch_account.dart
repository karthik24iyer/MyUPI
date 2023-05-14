import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myipu/entity/bank_detail.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchAccount extends StatefulWidget {
  const FetchAccount({Key? key}) : super(key: key);

  BankDetail getCurrentUserDetail() {
    // Future API logic
    return BankDetail(accountNo: 123456784452, bankName:'hdfc', bankFullName: 'HDFC Bank Ltd');
  }

  Future<String?> getAccountHolderName(String upiId) async {
    const url = 'https://upiapi.npci.org.in/ae/1.0/upi/indetails';
    final body = jsonEncode({'vpa': upiId});
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final name = data['AU'][0]['n'];
        return name;
      }
    } catch (e) {
      log('Error fetching account holder name: $e');
    }
    return null;
  }

  @override
  State<FetchAccount> createState() => _FetchAccountState();
}

class _FetchAccountState extends State<FetchAccount> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
