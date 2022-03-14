import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  // const NoticePage({ Key? key }) : super(key: key);

  final no_id, no_topic, no_description, no_firstname, no_lastname, no_date_create, no_app_name, no_image;
  NoticePage(this.no_id, this.no_topic, this.no_description, this.no_firstname, this.no_lastname, this.no_date_create, this.no_app_name, this.no_image);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  var no_id, no_topic, no_description, no_firstname, no_lastname, no_date_create, no_app_name, no_image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    no_id = widget.no_id;
    no_topic = widget.no_topic;
    no_description = widget.no_description;
    no_firstname = widget.no_firstname;
    no_lastname = widget.no_lastname;
    no_date_create = widget.no_date_create;
    no_app_name = widget.no_app_name;
    no_image = widget.no_image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดปัญหาแอปพลิเคชัน' ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.normal, fontFamily: 'CSPraKas',color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 74, 80, 87),
        actions: [
          
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:10 , right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 4),
              show_no_topic(),
        
              SizedBox(height: 4),
              show_no_app_name(),
        
              SizedBox(height: 4),
              show_no_name_create(),
        
              SizedBox(height: 4),
              show_no_date_create(),
        
              SizedBox(height: 20),
              new Divider(color: Color.fromARGB(255, 0, 0, 0),),
        
              SizedBox(height: 10),
              show_no_description(),

              SizedBox(height: 10),
              if(no_image != "")(
                show_no_image()
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: show_action_button(),
    );
  }

  Widget show_no_topic(){
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 5, top: 5, right: 5),
        child: Row(
          children: [
            Text("หัวข้อปัญหา : ", style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'CSPraKas',fontSize: 18)),
            Text("${no_topic}" , style: TextStyle(fontFamily: 'CSPraKas',fontSize: 18)),
          ],
        ), 
      ),
    );
  }

  Widget show_no_app_name(){
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 5, top: 5, right: 5),
        child: Row(
          children: [
            Text("ชื่อแอปพลิเคชัน : ", style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'CSPraKas',fontSize: 18)),
            Text("${no_app_name}", style: TextStyle(fontFamily: 'CSPraKas',fontSize: 18)),
          ],
        ), 
      ),
    );
  }

  Widget show_no_name_create(){
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 5, top: 5, right: 5),
        child: Row(
          children: [
            Text("ชื่อผู้ส่ง : ", style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'CSPraKas',fontSize: 18)),
            Text("${no_firstname} ${no_lastname}" , style: TextStyle(fontFamily: 'CSPraKas',fontSize: 18)),
          ],
        ), 
      ),
    );
  }

  Widget show_no_date_create(){
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 5, top: 5, right: 5),
        child: Row(
          children: [
            Text("เวลาแจ้งปัญหา : ", style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'CSPraKas',fontSize: 18)),
            Text(change_date_time_format()  , style: TextStyle(fontFamily: 'CSPraKas',fontSize: 18)),
          ],
        ), 
      ),
    );
  }

  Widget show_no_description(){
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 5, top: 5, right: 5),
        child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("รายละเอียดปัญหา", style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'CSPraKas',fontSize: 18)),
                
              ),
              SizedBox(height: 10,),
              Text("${no_description}", style: TextStyle(fontFamily: 'CSPraKas',fontSize: 18)),
            ],
          ),
      ), 
    );
  }

  String change_date_time_format(){
    String date_time_format = '';
    String day, month, year, hour, minute;
    List month_name = ["มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม",];

    year = no_date_create.substring(0,4);
    month = no_date_create.substring(5,7);
    day = no_date_create.substring(8,10);
    hour = no_date_create.substring(11,13);
    minute = no_date_create.substring(14,16);

    String month_thai = month_name[int.parse(month)-1];
    String year_buddhist = (int.parse(year)+543).toString();

    date_time_format = day+" "+month_thai+" "+year_buddhist+", "+hour+":"+minute+" น.";

    return date_time_format;
  }

  Widget show_action_button(){
    return Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            width: 180,
            height: 50,
            left: 10,
            bottom: 5,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              heroTag: 'back',
              onPressed: () {print("accepted");},
              child: Text(
                'รับดําเนินการ', style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'CSPraKas',fontSize: 20),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          Positioned(
            width: 180,
            height: 50,
            right: 10,
            bottom: 5,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              heroTag: 'next',
              onPressed: () {print("rejected");},
              child: Text(
                'ไม่รับดําเนินการ', style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'CSPraKas',fontSize: 20),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
      ],
    );
  }

  Widget show_no_image(){
    return Padding(
      padding: const EdgeInsets.only(bottom:80),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Image.network(
              no_image,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('รูปภาพ 1'),
                  ),
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
    );
  }
}