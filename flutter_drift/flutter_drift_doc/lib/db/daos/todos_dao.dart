import 'package:drift/drift.dart';
import 'package:flutter_drift_doc/db/database.dart';
import 'package:flutter_drift_doc/db/entity/todo.dart';

part 'todos_dao.g.dart';

// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<MyDatabase> with _$TodosDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  TodosDao(MyDatabase db) : super(db);

  Future<List<Todo>> get allTodoEntry async {
    return select(todos).get();
  }

  Stream<List<Todo>> todosInCategory(Category category) {
    if (category == null) {
      return (select(todos)..where((t) => isNull(t.category))).watch();
    } else {
      return (select(todos)..where((t) => t.category.equals(category.id)))
          .watch();
    }
  }
}
