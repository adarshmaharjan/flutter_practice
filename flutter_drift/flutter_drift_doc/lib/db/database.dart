import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drift_doc/db/daos/todos_dao.dart';
import 'package:flutter_drift_doc/db/entity/todo.dart';
import 'package:flutter_drift_doc/db/entity/catagories.dart';
import 'package:flutter_drift_doc/db/entity/user.dart';
import 'package:flutter_drift_doc/model/entry_with_category.dart';
import 'package:flutter_drift_doc/model/preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'myDatabase.sqlite'));
    debugPrint(file.toString());
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    Todos,
    Categories,
    Users,
  ],
  daos: [
    TodosDao,
  ],
)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (migrator, from, to) async {
          for (var table in allTables) {
            await migrator.deleteTable(table.actualTableName);
            await migrator.createTable(table);
          }
        },
      );

  Future deleteEverything() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }

  Future<List<Todo>> get allTodoEntry => select(todos).get();

  Future<List<Todo>> limitTodos(int limit, {int offset = 0}) {
    return (select(todos)..limit(limit, offset: offset)).get();
  }

  Future<List<Todo>> sortEntriesAlphabetically() {
    return (select(todos)..orderBy([(t) => OrderingTerm(expression: t.title)]))
        .get();
  }

  Stream<List<Todo>> watchEntriesInCategory(Category c) {
    return (select(todos)
          ..where(
            (t) => t.category.equals(c.id),
          ))
        .watch();
  }

  Stream<Todo> entryById(int id) {
    return (select(todos)..where((t) => t.id.equals(id))).watchSingle();
  }

  Stream<List<String>> contentWithLongTiles() {
    final query = select(todos)
      ..where((t) => t.title.length.isBiggerOrEqualValue(16));
    return query.map((row) => row.content).watch();
  }

  //!Deferring get vs watch
  MultiSelectable<Todo> pageOfTodos(int page, {int pageSize = 10}) {
    return select(todos)..limit(pageSize, offset: page);
  }

  SingleSelectable<Todo> entryByIdSelectable(int id) {
    return select(todos)..where((t) => t.id.equals(id));
  }

  SingleOrNullSelectable<Todo> entryFromExternalLink(int id) {
    return select(todos)..where((t) => t.id.equals(id));
  }

  //!Deferring get vs watch

  Future moveImportantTasksIntoCategory(Category target) {
    return (update(todos)..where((t) => t.title.like('%Important%'))).write(
      TodosCompanion(
        category: Value(target.id),
      ),
    );
  }

  Future updateTodoWithModel(Todo entry) {
    return update(todos).replace(entry);
  }

  Future deleteOldestNineTask() {
    return (delete(todos)
          ..where(
            (tbl) => tbl.id.isSmallerThanValue(10),
          ))
        .go();
  }

  Future<int> addTodo(TodosCompanion entry) {
    return into(todos).insert(entry);
  }

  Future<void> insertMultipleEntries() async {
    await batch((batch) {
      batch.insertAll(todos, [
        TodosCompanion.insert(
          title: "First Entry",
          content: "My Content",
        ),
        TodosCompanion.insert(
          title: "Another Entry",
          content: "More Content",
          category: const Value(3),
        )
      ]);
    });
  }

  Stream<List<EntryWithCategory>> entriesWithCategory() {
    final query = select(todos).join([
      leftOuterJoin(categories, categories.id.equalsExp(todos.category)),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return EntryWithCategory(
          row.readTable(todos),
          row.readTableOrNull(categories),
        );
      }).toList();
    });
  }
}
