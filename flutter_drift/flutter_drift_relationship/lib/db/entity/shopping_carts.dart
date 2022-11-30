import 'package:drift/drift.dart';

class ShoppingCarts extends Table {
  IntColumn get id => integer().autoIncrement()();
  // we could also store some further information about the user creating
  // this cart etc.
}
