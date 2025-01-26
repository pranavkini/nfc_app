import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nfc_card_manager/models/card_model.dart';

class CardProvider extends ChangeNotifier {
  List<CardModel> _cards = [];

  List<CardModel> get cards => _cards;

  Future<void> loadCards() async {
    try {
      final box = await Hive.openBox<CardModel>('cardsBox');
      _cards = box.values.toList(); // Load all cards into the list
      print('Loaded cards: $_cards');
      notifyListeners(); // Notify UI of updates
    } catch (e) {
      print('Error loading cards: $e');
    }
  }

  Future<void> addCard(CardModel card) async {
    final box = await Hive.openBox<CardModel>('cardsBox');
    await box.put(card.id, card);
    _cards = box.values.toList();
    notifyListeners();
  }

  Future<void> deleteCard(String id) async {
    final box = await Hive.openBox<CardModel>('cardsBox');
    await box.delete(id);
    await loadCards();
    notifyListeners();
  }
}
