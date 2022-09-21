import 'package:flutter/material.dart';
import 'package:payment_c6/shared/common/constants.dart';

class CashScreen extends StatelessWidget {
  const CashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please go to supermarket'),
            SizedBox(height: 25,),
            Text(REFCODE,style: TextStyle(color: Colors.deepOrange),),
          ],
        ),
      ),
    );
  }
}
