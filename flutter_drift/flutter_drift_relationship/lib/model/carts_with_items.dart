import 'package:flutter_drift_relationship/db/app_db.dart';

class CartWithItems {
  final ShoppingCart cart;
  final List<BuyableItem> items;

  CartWithItems(this.cart, this.items);
}
