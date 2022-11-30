import 'package:flutter_drift_doc/db/database.dart';

class EntryWithCategory {
  EntryWithCategory(this.entry, this.category);

  final Todo? entry;
  final Category? category;
}
