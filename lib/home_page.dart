import 'package:flutter/material.dart';
import 'package:lipa_sasa/mpesa_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: FilledButton(onPressed: () async {
            final api = MPesaApi();
            final credentials = await api.getAccessToken();
            print('------------CREDENTIALS!!!!! : ${credentials}');

          }, child: Text('Make API Request')),
        ),
      ),
    );
  }
}
