import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {

  String scanResult="неизвестно";
  
  final TextEditingController qrTextController=TextEditingController(text: "Hello");


  scanQr_Code() async {
    String scanQr_Result;
    try{
      scanQr_Result=await FlutterBarcodeScanner.scanBarcode("#ff6666", "Отмена", true, ScanMode.QR);
    } on PlatformException{
      scanQr_Result="попробуй позже, сорри";
    }

    if (!mounted) return;

    setState(() {
      scanResult=scanQr_Result;
      showDialog(context: context, builder: (_){
        return AlertDialog(title: Text("АЛАРМ_SOS"), content: Text(scanResult),);
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("БЛАбЛа"),),
      body: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        QrImage(
          data: qrTextController.text,
          version: QrVersions.auto,
          size: 220,
        ),
        TextFormField(
          controller: qrTextController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            label: Text("Сообщение"),
            suffix: IconButton(icon: Icon(Icons.send), 
              onPressed: (){
              setState(() {
                qrTextController.text;
              });
              } ,
            ),
          ),
          onSaved: (input){
            qrTextController.text=input!;
          },
        ),
        MaterialButton(onPressed: (){
          scanQr_Code();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.qr_code),
            Text("сканировать код"),
          ],
        ),
        )
      ],
      ),
    );
  }
}
