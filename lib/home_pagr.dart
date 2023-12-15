import 'package:flutter/material.dart';
import 'package:lugat_home_work/page1.dart';
import 'package:lugat_home_work/service/data_base_service.dart';

import 'model/lugat_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DataBaseService dataBaseService=DataBaseService();

  TextEditingController textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
              ),
              ElevatedButton(onPressed: (){

                dataBaseService.addWord(LugatModel(textEditingController.text, textEditingController.text+" uzbek")).then((value) {

                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Page1()));
              }, child:Text("Send"))
            ],
          ),
        ),
      ),
    );
  }
}
