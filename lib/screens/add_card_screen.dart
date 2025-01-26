import 'package:flutter/material.dart';
import 'package:nfc_card_manager/models/card_model.dart';
import 'package:nfc_card_manager/providers/card_provider.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  bool isScanning = false;

  Future<void> scanCard() async {
    setState(() {
      isScanning = true;
    });

    try {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        final nfcData = tag.data.toString();
        NfcManager.instance.stopSession();

        final card = CardModel(
            id: Uuid().v4(),
            cardName: 'New Card',
            name: 'Employee Name',
            surname: 'Surname',
            sapId: 'sapId',
            nfcData: nfcData);

        Provider.of<CardProvider>(context, listen: false).addCard(card);
        print('Scanned NFC Data: $nfcData');
        print('Saved Card: ${card.cardName}');  
        setState(() => isScanning = false);
        Navigator.pop(context);
      });
    } catch (e) {
      setState(() => isScanning = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Reading NFC: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Card')),
      body: Center(
        child: isScanning
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: scanCard,
                child: Text('Scan NFC Card'),
              ),
      ),
    );
  }
}
