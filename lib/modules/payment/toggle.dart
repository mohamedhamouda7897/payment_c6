import 'package:flutter/material.dart';
import 'package:payment_c6/modules/payment/cach.dart';
import 'package:payment_c6/modules/payment/visa.dart';
import 'package:payment_c6/shared/common/components.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultButton(function: () {
            NavigateTo(context, VisCard());
          }, text: 'Pay with card'),
          SizedBox(
            height: 40,
          ),
          defaultButton(function: () {
            NavigateTo(context, CashScreen());
          }, text: 'Pay with kiosk'),
        ],
      ),
    );
  }
}
