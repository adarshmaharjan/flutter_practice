// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class BuyableItem extends DataClass implements Insertable<BuyableItem> {
  final int id;
  final String description;
  final int price;
  BuyableItem(
      {required this.id, required this.description, required this.price});
  factory BuyableItem.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return BuyableItem(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      price: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['description'] = Variable<String>(description);
    map['price'] = Variable<int>(price);
    return map;
  }

  BuyableItemsCompanion toCompanion(bool nullToAbsent) {
    return BuyableItemsCompanion(
      id: Value(id),
      description: Value(description),
      price: Value(price),
    );
  }

  factory BuyableItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BuyableItem(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      price: serializer.fromJson<int>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
      'price': serializer.toJson<int>(price),
    };
  }

  BuyableItem copyWith({int? id, String? description, int? price}) =>
      BuyableItem(
        id: id ?? this.id,
        description: description ?? this.description,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('BuyableItem(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, description, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BuyableItem &&
          other.id == this.id &&
          other.description == this.description &&
          other.price == this.price);
}

class BuyableItemsCompanion extends UpdateCompanion<BuyableItem> {
  final Value<int> id;
  final Value<String> description;
  final Value<int> price;
  const BuyableItemsCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
  });
  BuyableItemsCompanion.insert({
    this.id = const Value.absent(),
    required String description,
    required int price,
  })  : description = Value(description),
        price = Value(price);
  static Insertable<BuyableItem> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<int>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
    });
  }

  BuyableItemsCompanion copyWith(
      {Value<int>? id, Value<String>? description, Value<int>? price}) {
    return BuyableItemsCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuyableItemsCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $BuyableItemsTable extends BuyableItems
    with TableInfo<$BuyableItemsTable, BuyableItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuyableItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int?> price = GeneratedColumn<int?>(
      'price', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, description, price];
  @override
  String get aliasedName => _alias ?? 'buyable_items';
  @override
  String get actualTableName => 'buyable_items';
  @override
  VerificationContext validateIntegrity(Insertable<BuyableItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BuyableItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return BuyableItem.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BuyableItemsTable createAlias(String alias) {
    return $BuyableItemsTable(attachedDatabase, alias);
  }
}

class ShoppingCart extends DataClass implements Insertable<ShoppingCart> {
  final int id;
  ShoppingCart({required this.id});
  factory ShoppingCart.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ShoppingCart(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    return map;
  }

  ShoppingCartsCompanion toCompanion(bool nullToAbsent) {
    return ShoppingCartsCompanion(
      id: Value(id),
    );
  }

  factory ShoppingCart.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingCart(
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
    };
  }

  ShoppingCart copyWith({int? id}) => ShoppingCart(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('ShoppingCart(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ShoppingCart && other.id == this.id);
}

class ShoppingCartsCompanion extends UpdateCompanion<ShoppingCart> {
  final Value<int> id;
  const ShoppingCartsCompanion({
    this.id = const Value.absent(),
  });
  ShoppingCartsCompanion.insert({
    this.id = const Value.absent(),
  });
  static Insertable<ShoppingCart> custom({
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  ShoppingCartsCompanion copyWith({Value<int>? id}) {
    return ShoppingCartsCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingCartsCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $ShoppingCartsTable extends ShoppingCarts
    with TableInfo<$ShoppingCartsTable, ShoppingCart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingCartsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? 'shopping_carts';
  @override
  String get actualTableName => 'shopping_carts';
  @override
  VerificationContext validateIntegrity(Insertable<ShoppingCart> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShoppingCart map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ShoppingCart.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ShoppingCartsTable createAlias(String alias) {
    return $ShoppingCartsTable(attachedDatabase, alias);
  }
}

class ShoppingCartEntry extends DataClass
    implements Insertable<ShoppingCartEntry> {
  final int shoppingCart;
  final int item;
  ShoppingCartEntry({required this.shoppingCart, required this.item});
  factory ShoppingCartEntry.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ShoppingCartEntry(
      shoppingCart: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}shopping_cart'])!,
      item: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shopping_cart'] = Variable<int>(shoppingCart);
    map['item'] = Variable<int>(item);
    return map;
  }

  ShoppingCartEntriesCompanion toCompanion(bool nullToAbsent) {
    return ShoppingCartEntriesCompanion(
      shoppingCart: Value(shoppingCart),
      item: Value(item),
    );
  }

  factory ShoppingCartEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingCartEntry(
      shoppingCart: serializer.fromJson<int>(json['shoppingCart']),
      item: serializer.fromJson<int>(json['item']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shoppingCart': serializer.toJson<int>(shoppingCart),
      'item': serializer.toJson<int>(item),
    };
  }

  ShoppingCartEntry copyWith({int? shoppingCart, int? item}) =>
      ShoppingCartEntry(
        shoppingCart: shoppingCart ?? this.shoppingCart,
        item: item ?? this.item,
      );
  @override
  String toString() {
    return (StringBuffer('ShoppingCartEntry(')
          ..write('shoppingCart: $shoppingCart, ')
          ..write('item: $item')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(shoppingCart, item);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingCartEntry &&
          other.shoppingCart == this.shoppingCart &&
          other.item == this.item);
}

class ShoppingCartEntriesCompanion extends UpdateCompanion<ShoppingCartEntry> {
  final Value<int> shoppingCart;
  final Value<int> item;
  const ShoppingCartEntriesCompanion({
    this.shoppingCart = const Value.absent(),
    this.item = const Value.absent(),
  });
  ShoppingCartEntriesCompanion.insert({
    required int shoppingCart,
    required int item,
  })  : shoppingCart = Value(shoppingCart),
        item = Value(item);
  static Insertable<ShoppingCartEntry> custom({
    Expression<int>? shoppingCart,
    Expression<int>? item,
  }) {
    return RawValuesInsertable({
      if (shoppingCart != null) 'shopping_cart': shoppingCart,
      if (item != null) 'item': item,
    });
  }

  ShoppingCartEntriesCompanion copyWith(
      {Value<int>? shoppingCart, Value<int>? item}) {
    return ShoppingCartEntriesCompanion(
      shoppingCart: shoppingCart ?? this.shoppingCart,
      item: item ?? this.item,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shoppingCart.present) {
      map['shopping_cart'] = Variable<int>(shoppingCart.value);
    }
    if (item.present) {
      map['item'] = Variable<int>(item.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingCartEntriesCompanion(')
          ..write('shoppingCart: $shoppingCart, ')
          ..write('item: $item')
          ..write(')'))
        .toString();
  }
}

class $ShoppingCartEntriesTable extends ShoppingCartEntries
    with TableInfo<$ShoppingCartEntriesTable, ShoppingCartEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingCartEntriesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _shoppingCartMeta =
      const VerificationMeta('shoppingCart');
  @override
  late final GeneratedColumn<int?> shoppingCart = GeneratedColumn<int?>(
      'shopping_cart', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES shopping_carts (id)');
  final VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<int?> item = GeneratedColumn<int?>(
      'item', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES buyable_items (id)');
  @override
  List<GeneratedColumn> get $columns => [shoppingCart, item];
  @override
  String get aliasedName => _alias ?? 'shopping_cart_entries';
  @override
  String get actualTableName => 'shopping_cart_entries';
  @override
  VerificationContext validateIntegrity(Insertable<ShoppingCartEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('shopping_cart')) {
      context.handle(
          _shoppingCartMeta,
          shoppingCart.isAcceptableOrUnknown(
              data['shopping_cart']!, _shoppingCartMeta));
    } else if (isInserting) {
      context.missing(_shoppingCartMeta);
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item']!, _itemMeta));
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ShoppingCartEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ShoppingCartEntry.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ShoppingCartEntriesTable createAlias(String alias) {
    return $ShoppingCartEntriesTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $BuyableItemsTable buyableItems = $BuyableItemsTable(this);
  late final $ShoppingCartsTable shoppingCarts = $ShoppingCartsTable(this);
  late final $ShoppingCartEntriesTable shoppingCartEntries =
      $ShoppingCartEntriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [buyableItems, shoppingCarts, shoppingCartEntries];
}
