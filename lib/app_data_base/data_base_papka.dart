import 'dart:async';

import 'package:floor/floor.dart';
import 'package:lugat_home_work/dao/lugat_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite; // diqqat buni qo'shish kerak
import '../model/lugat_model.dart';
part 'data_base_papka.g.dart';
@Database(version: 1, entities: [LugatModel])
abstract class AppDataBase extends FloorDatabase{
  LugatDao get lugatDao;
}