import 'package:drift/drift.dart';
import 'package:flutter_drift_relationship/db/entity/buyable_items.dart';
import 'package:flutter_drift_relationship/db/entity/shopping_carts.dart';

@DataClassName('ShoppingCartEntry')
class ShoppingCartEntries extends Table {
  IntColumn get shoppingCart => integer().references(ShoppingCarts, #id)();
  IntColumn get item => integer().references(BuyableItems, #id)();
}
