import 'package:flutter/material.dart';
import 'package:lugat_home_work/model/lugat_model.dart';
import 'package:lugat_home_work/service/data_base_service.dart';

class PageDictionary extends StatefulWidget {
  const PageDictionary({Key? key}) : super(key: key);

  @override
  State<PageDictionary> createState() => _PageDictionaryState();
}

class _PageDictionaryState extends State<PageDictionary> {

  TextEditingController searcheController=TextEditingController();
  TextEditingController englishController=TextEditingController();
  TextEditingController uzbekController=TextEditingController();
  DataBaseService dataBaseService=DataBaseService();
  List<LugatModel> list=[];
  List<LugatModel> listUzbek=[];
  bool changePosition=false;
  LugatModel? find;  // topigan sozni keltirib chiqarish

  @override
  void initState() {
    dataBaseService.boshlanishDB().then((value){
      dataBaseService.allInformation().then((value1){
        setState(() {
          list=value1;

        });
      });
      dataBaseService.allInformationUzbek().then((value2){
        setState(() {
          listUzbek=value2;

        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(child: Image.asset("assets/OIP.jpg",fit: BoxFit.fill,width: 450,height: 800,)),
          SafeArea(child:
           Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  width: 250,
                  height: 60,

                  child: TextField(
                    style: TextStyle(fontSize: 22,color: Colors.white),
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    controller: searcheController,
                    decoration: InputDecoration(

                        border: OutlineInputBorder(),
                        focusColor: Colors.white,
                        filled:true,
                        floatingLabelStyle:TextStyle(color: Colors.white) ,
                        fillColor: Color(0x5AEF08A6),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              if(changePosition){
                                list.forEach((element) {
                                  if( searcheController.text.toUpperCase()==element.english.toUpperCase()){
                                    find=element;
                                  }
                                });
                              }
                              else{
                                listUzbek.forEach((element) {
                                  if(searcheController.text.toUpperCase()==element.uzbek.toUpperCase()){
                                    find=element;
                                  }
                                });
                              }
                            });
                          },
                          icon: Icon(Icons.search,size: 25,color: Colors.amberAccent,),
                        )
                    ),

                  ),
                ),
              ), // birinchi qator
              find!=null?Container(
                padding: EdgeInsets.only(left: 50),
                child: Row(children: [
                  Text("English: ${find?.english} ---  Uzbek: ${find?.uzbek}", style: TextStyle(fontSize: 20,color:Colors.white))
                ],),
              ):Container(
                width: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width:100,
                      child: Text(changePosition?"Eng":"Uzb",style: TextStyle(fontSize: 20,color: Colors.white),)),
                  GestureDetector(onTap: (){
                    setState(() {
                      changePosition=!changePosition;
                    });

                  },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        boxShadow:[
                          BoxShadow(blurRadius: 20),]
                      ),
                      child: Image.asset("assets/replace.jpg",width: 30,fit:BoxFit.fill,),
                    ),),
                  Container(
                      width: 100,
                      padding: EdgeInsets.only(left: 40),
                      child: Text(changePosition?"Uzb":"Eng",style: TextStyle(fontSize: 20,color: Colors.white),)),
                ],
              ),    // ikkinchi qator
              Container(
                width: 350,
                height: 570,
                decoration: BoxDecoration(

                ),
                child: ListView.builder(itemBuilder: ((context, index) {
                  return itemBuilder(index);
                   }),
                  itemCount:list.length,
                )

              )  // uchunchi jadval qatori
            ]
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            showDialog(context: context, builder: (context)=>AlertDialog(
              title: Text("Add your English and Uzbek word"),
              content: Text("only Enlish and Uzbek word"),
              actions: [
                TextField(
                  controller: englishController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enlish word"
                  ),
                ),
                TextField(
                  controller: uzbekController,
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
            hintText: "Uzbek word"),),
                ElevatedButton(onPressed: (){
                  setState(() {
                    dataBaseService.addWord(LugatModel(englishController.text, uzbekController.text)).then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PageDictionary()));
                    });
                  });
                },
                child: Text("Add the words"),)
              ],
            ));
          });
        },
      ),
    );
  }
  Widget itemBuilder(int index){
    return  Container(
        height: 30,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              width: 160,
                child: Text(changePosition?"${list[index].english}":"${listUzbek[index].uzbek}",
                    style: TextStyle(fontSize: 20,color:Colors.white))),
            Container(
              width: 160,
                child: Text(changePosition?"${list[index].uzbek}":"${listUzbek[index].english}",
                    style: TextStyle(fontSize: 20,color:Colors.white))),
            Container(
              width: 30,
                child: IconButton(onPressed: (){
                  setState(() {
                    dataBaseService.deletWord(list[index]);
                    initState();
                  });
                },
                icon: Icon(Icons.remove_circle_outline,color: Colors.red))
                )
          ],
        ),
      );

  }
}
