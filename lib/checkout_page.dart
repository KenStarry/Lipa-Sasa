import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lipa_sasa/mpesa_api.dart';
import 'package:lipa_sasa/receipt.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Future<void> savePDF() async {
    final pdf = pw.Document(title: 'Lipa Sasa Receipt');

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Container(child: pw.Text('Hello'))));

    final status = await Permission.storage.request();

    if (status.isGranted) {
      final path = await getExternalStorageDirectory();
      final newPath =
          '${path?.path}/lipa-sasa';
      final pathExists = await Directory(newPath).exists();

      if (pathExists) {
        final file = File('$newPath/lipa_sasa.pdf');
        await file.writeAsBytes(await pdf.save());
      } else {
        await Directory(newPath).create();
        final file = File('$newPath/lipa_sasa.pdf');
        await file.writeAsBytes(await pdf.save());
      }
    }
  }

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
            FilledButton(
                onPressed: () async {
                  //  download pdf file logic
                  await savePDF();
                },
                child: Text('Download PDF')),
            Center(
              child: FilledButton(
                  onPressed: () async {
                    final api = MPesaApi();
                    await api.sendSTKPush();
                  },
                  child: Text('Make API Request')),
            ),
          ],
        ),
      ),
    );
  }
}
