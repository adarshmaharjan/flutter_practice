import 'package:drift/drift.dart';

class BuyableItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  IntColumn get price => integer()();
  // we could add more columns as we wish.
}
