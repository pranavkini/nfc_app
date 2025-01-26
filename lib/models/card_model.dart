import 'package:hive/hive.dart';

part 'card_model.g.dart';

@HiveType(typeId: 0)
class CardModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String cardName;

  @HiveField(2)
  String name;

  @HiveField(3)
  String surname;

  @HiveField(4)
  String sapId;

  @HiveField(5)
  String nfcData;

  CardModel({
    required this.id,
    required this.cardName,
    required this.name,
    required this.surname,
    required this.sapId,
    required this.nfcData,
  });

  // CopyWith method to update fields
  CardModel copyWith({
    String? id,
    String? cardName,
    String? name,
    String? surname,
    String? sapId,
    String? nfcData,
  }) {
    return CardModel(
      id: id ?? this.id,
      cardName: cardName ?? this.cardName,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      sapId: sapId ?? this.sapId,
      nfcData: nfcData ?? this.nfcData,
    );
  }

  @override
  String toString() {
    return 'CardModel(id: $id, cardName: $cardName, name: $name, surname: $surname, sapId: $sapId, nfcData: $nfcData)';
  }
}
