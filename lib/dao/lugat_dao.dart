import 'package:floor/floor.dart';

import '../model/lugat_model.dart';

@dao
abstract class LugatDao{

  @Query('SELECT * FROM LugatModel ORDER by english') Future<List<LugatModel>> umumiyMalumot();
  @Query('SELECT * FROM LugatModel ORDER by uzbek') Future<List<LugatModel>> umumiyMalumotUzbek();

  @insert Future<void>malumotQoshish(LugatModel lugatModel);

  @delete Future<void> deletSoz(LugatModel lugatModel);
  
}