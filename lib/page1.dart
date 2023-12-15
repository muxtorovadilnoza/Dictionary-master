import 'package:flutter/material.dart';
import 'package:lugat_home_work/service/data_base_service.dart';

import 'model/lugat_model.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {


  DataBaseService dataBaseService=DataBaseService();
  List<LugatModel> list=[];

  @override
  void initState() {

    dataBaseService.boshlanishDB().then((value){
      dataBaseService.allInformation().then((value1){
        setState(() {
          list=value1;

        });
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Text("${list[0].english}   ${list[0].id}  ${list[0].uzbek}"),
      )),
    );
  }
}
