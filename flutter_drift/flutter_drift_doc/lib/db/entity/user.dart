import 'package:drift/drift.dart';
import 'package:flutter_drift_doc/model/preferences.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  TextColumn get preferences =>
      text().map(const PreferenceConverter()).nullable()();
}
