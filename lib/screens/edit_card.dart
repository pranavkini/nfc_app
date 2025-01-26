import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';
import '../models/card_model.dart';

class EditCardScreen extends StatefulWidget {
  final CardModel card;

  const EditCardScreen({Key? key, required this.card}) : super(key: key);

  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  late TextEditingController _cardNameController;
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _sapIdController;

  @override
  void initState() {
    super.initState();
    _cardNameController = TextEditingController(text: widget.card.cardName);
    _nameController = TextEditingController(text: widget.card.name);
    _surnameController = TextEditingController(text: widget.card.surname);
    _sapIdController = TextEditingController(text: widget.card.sapId);
  }

  @override
  void dispose() {
    _cardNameController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _sapIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cardNameController,
              decoration: InputDecoration(labelText: 'Card Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _surnameController,
              decoration: InputDecoration(labelText: 'Surname'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _sapIdController,
              decoration: InputDecoration(labelText: 'SAP ID'),
            ),
            SizedBox(height: 10),
            // Make the NFC Data field read-only
            TextField(
              controller: TextEditingController(text: widget.card.nfcData),
              decoration: InputDecoration(labelText: 'NFC Data'),
              enabled: false, // Disable editing
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updatedCard = widget.card.copyWith(
                  cardName: _cardNameController.text,
                  name: _nameController.text,
                  surname: _surnameController.text,
                  sapId: _sapIdController.text,
                  nfcData: widget.card.nfcData, // Keep the original NFC data
                );

                await cardProvider.addCard(updatedCard); // Update the card
                Navigator.pop(context); // Go back after saving
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
