import 'package:flutter/material.dart';
import 'package:lipa_sasa/mpesa_api.dart';
import 'package:lipa_sasa/receipt.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Receipt(),
            Center(
              child: FilledButton(onPressed: () async {
                final api = MPesaApi();
                await api.sendSTKPush();
              }, child: Text('Make API Request')),
            ),
          ],
        ),
      ),
    );
  }
}
