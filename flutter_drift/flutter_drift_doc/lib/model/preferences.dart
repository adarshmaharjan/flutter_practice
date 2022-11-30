import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'preferences.g.dart';

@j.JsonSerializable()
class Preferences {
  bool receiveEmails;
  String selectedTheme;

  Preferences(this.receiveEmails, this.selectedTheme);

  factory Preferences.fromJson(Map<String, dynamic> json) =>
      _$PreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$PreferencesToJson(this);
}

class PreferenceConverter extends TypeConverter<List<Preferences>, String> {
  const PreferenceConverter();

  @override
  Preferences fromSql(String fromDb) {
    return Preferences.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(Preferences value) {
    return json.encode(value.toJson());
  }

  @override
  List<Preferences>? mapToDart(String? fromDb) {
    if (fromDb != null && fromDb.isNotEmpty) {
      final map = jsonDecode(fromDb) as List<dynamic>;
      return List<Preferences>.from(map.map((e) => Preferences.fromJson(e)));
    }
    return null;
  }

  @override
  String? mapToSql(List<Preferences>? value) {
    if (value == null) return null;
    final list = value.map((e) => e.toJson()).toList();
    return jsonEncode(list);
  }

  // @override
  // List<Donations>? mapToDart(String? fromDb) {
  //   if (fromDb != null && fromDb.isNotEmpty) {
  //     final map = jsonDecode(fromDb) as List<dynamic>;
  //     return List<Donations>.from(map.map((e) => Donations.fromJson(e)));
  //   }
  //   return null;
  // }

  // @override
  // String? mapToSql(List<Donations>? value) {
  //   if (value == null) return null;
  //   final list = value.map((e) => e.toJson()).toList();
  //   return jsonEncode(list);
  // }
}
