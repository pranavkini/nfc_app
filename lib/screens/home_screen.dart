import 'package:flutter/material.dart';
import 'package:nfc_card_manager/screens/edit_card.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';
import '../models/card_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _loadCardsFuture;

  @override
  void initState() {
    super.initState();
    final cardProvider = Provider.of<CardProvider>(context, listen: false);
    _loadCardsFuture = cardProvider.loadCards(); // Cache the future
  }

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Card Manager'),
      ),
      body: FutureBuilder(
        future: _loadCardsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Error loading cards: ${snapshot.error}'));
          }
          if (cardProvider.cards.isEmpty) {
            return Center(child: Text('No cards stored yet.'));
          }
          return ListView.builder(
            itemCount: cardProvider.cards.length,
            itemBuilder: (context, index) {
              final card = cardProvider.cards[index];
              return ListTile(
                title: Text(card.cardName),
                subtitle: Text('${card.name} - ${card.surname}'),
                onTap: () {
                  Navigator.pushNamed(context, '/emulate-card',
                      arguments: card);
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditCardScreen(card: card),
                            ));
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          _showDeleteDialog(context, cardProvider, card.id);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-card');
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, CardProvider cardProvider, String cardId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Card'),
        content: Text('Are you sure you want to delete this card?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Cancel and close the dialog
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Delete the card using the correct provider instance
              await cardProvider.deleteCard(cardId);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}

}
