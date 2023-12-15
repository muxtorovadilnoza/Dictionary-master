import '../app_data_base/data_base_papka.dart';
import '../model/lugat_model.dart';

class DataBaseService{
  static final DataBaseService _service=DataBaseService._internal();
  factory DataBaseService(){
    return _service;
  }
  DataBaseService._internal();
  late AppDataBase _appDataBase;

  boshlanishDB()async{
    _appDataBase=await $FloorAppDataBase.databaseBuilder('lugatningDataBazasi.db').build();
    // manashu narsa DB ni yaratadi
  }
  Future<List<LugatModel>> allInformation()async {
    return await _appDataBase.lugatDao.umumiyMalumot();
  }
  Future<List<LugatModel>> allInformationUzbek()async {
    return await _appDataBase.lugatDao.umumiyMalumotUzbek();
  }
  Future<void> addWord(LugatModel lugatModel) async{
    return await _appDataBase.lugatDao.malumotQoshish(lugatModel);
  }
  // Future<void> removeWord(LugatModel lugatModel) async{
  //   return await _appDataBase.lugatDao.deletWord(lugatModel);
  // }
  Future<void>deletWord(LugatModel lugatModel) async{
    return await _appDataBase.lugatDao.deletSoz(lugatModel);
  }
}