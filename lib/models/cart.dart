import 'package:hive/hive.dart';
part 'cart.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String buah;

  @HiveField(2)
  final String harga;

  Item({
    required this.buah,
    required this.harga,
  });
}
