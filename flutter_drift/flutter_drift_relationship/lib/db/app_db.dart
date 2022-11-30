import 'package:drift/drift.dart';

import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_drift_relationship/db/entity/buyable_items.dart';
import 'package:flutter_drift_relationship/db/entity/shopping_cart_entries.dart';
import 'package:flutter_drift_relationship/db/entity/shopping_carts.dart';
import 'package:flutter_drift_relationship/model/carts_with_items.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:rxdart/rxdart.dart';

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_db_mtmr.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [BuyableItems, ShoppingCarts, ShoppingCartEntries])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;
  // !We assume that all the BuyableItems included already exist in the database (we could store them via into(buyableItems).insert(BuyableItemsCompanion(...))).
  //TODO:So lets call this method dosenof time before we use other methods below .

  Future<int> addBuyableItem(BuyableItemsCompanion entry) {
    return into(buyableItems).insert(entry);
  }

  Future<void> writeShoppingCart(CartWithItems entry) {
    return transaction(() async {
      final cart = entry.cart;
      await into(shoppingCarts).insert(cart, mode: InsertMode.replace);
      await (delete(shoppingCartEntries)
            ..where(
              (entry) => entry.shoppingCart.equals(cart.id),
            ))
          .go();
      for (final item in entry.items) {
        await into(shoppingCartEntries).insert(ShoppingCartEntry(
          shoppingCart: cart.id,
          item: item.id,
        ));
      }
    });
  }

  Future<CartWithItems> createEmptyCart() async {
    final id = await into(shoppingCarts).insert(const ShoppingCartsCompanion());
    final cart = ShoppingCart(id: id);
    return CartWithItems(cart, []);
  }

  Stream<CartWithItems> watchCart(int id) {
    final cartQuery = select(shoppingCarts)
      ..where((cart) => cart.id.equals(id));
    final contentQuery = select(shoppingCartEntries).join([
      innerJoin(
          buyableItems, buyableItems.id.equalsExp(shoppingCartEntries.item)),
    ])
      ..where(shoppingCartEntries.shoppingCart.equals(id));
    final cartStream = cartQuery.watchSingle();

    final contentStream = contentQuery.watch().map((rows) {
      return rows.map((row) => row.readTable(buyableItems)).toList();
    });

    return Rx.combineLatest2(cartStream, contentStream,
        (ShoppingCart cart, List<BuyableItem> items) {
      return CartWithItems(cart, items);
    });
  }

  Stream<List<CartWithItems>> watchAllCarts() {
    final cartStream = select(shoppingCarts).watch();

    return cartStream.switchMap((carts) {
      final idToCart = {for (var cart in carts) cart.id: cart};
      final ids = idToCart.keys;

      final entryQuery = select(shoppingCartEntries).join([
        innerJoin(
          buyableItems,
          buyableItems.id.equalsExp(shoppingCartEntries.item),
        ),
      ])
        ..where(shoppingCartEntries.shoppingCart.isIn(ids));
      final idToItems = <int, List<BuyableItem>>{};
      return entryQuery.watch().map((rows) {
        for (final row in rows) {
          final item = row.readTable(buyableItems);
          final id = row.readTable(shoppingCartEntries).shoppingCart;

          idToItems.putIfAbsent(id, () => []).add(item);
        }
        return [
          for (var id in ids) CartWithItems(idToCart[id]!, idToItems[id] ?? [])
        ];
      });
    });
  }
}
