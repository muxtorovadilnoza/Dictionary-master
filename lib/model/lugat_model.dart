import 'package:floor/floor.dart';

@entity
class LugatModel{  // Aslida berilgan Jadval nomi
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String english;
  final String uzbek;

  LugatModel(this.english, this.uzbek, {this.id});  // savol {} ga nega olindi
}