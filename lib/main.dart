import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nfc_card_manager/models/card_model.dart';
import 'package:nfc_card_manager/providers/card_provider.dart';
import 'package:nfc_card_manager/screens/add_card_screen.dart';
import 'package:nfc_card_manager/screens/edit_card.dart';
import 'package:nfc_card_manager/screens/emulate_card.dart';
import 'package:nfc_card_manager/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CardModelAdapter());
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CardProvider()),
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFC Card Manager',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add-card': (context) => AddCardScreen(),
        '/emulate-card': (context){
          final card = ModalRoute.of(context)!.settings.arguments as CardModel;
          return EmulateCardScreen(card: card);
        },
      },
    );
  }
}
