import 'package:flutter/material.dart';
import 'package:nfc_card_manager/models/card_model.dart';

class EmulateCardScreen extends StatelessWidget {
  final CardModel card;

  EmulateCardScreen({required this.card});

  Future<void> emulateCard(BuildContext context) async {
    // Simulate the emulation of the NFC card
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Emulating card: ${card.cardName}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emulate Card')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => emulateCard(context),
          child: Text('Emulate Card'),
        ),
      ),
    );
  }
}
