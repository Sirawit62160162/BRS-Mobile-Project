import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:brsmobileproject/pages/login.dart';
import 'package:brsmobileproject/pages/notice.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  final mem_id, mem_firstname, mem_lastname, mem_email;
  HomePage(this.mem_id, this.mem_firstname, this.mem_lastname, this.mem_email);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var mem_id;
  var mem_firstname; 
  var mem_lastname;
  var mem_email;

  List notice_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mem_id = widget.mem_id;
    mem_firstname = widget.mem_firstname;
    mem_lastname = widget.mem_lastname;
    mem_email = widget.mem_email;

    get_notice_list();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 0,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 180, 180, 180),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color.fromARGB(255, 101, 107, 112), //desired color
          ),
          
          child: show_home_drawer(),
        ),
        appBar: AppBar(
          title: const Text('รายการปัญหาแอปพลิเคชัน' ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.normal, fontFamily: 'CSPraKas',color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 74, 80, 87),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  notice_list = [];
                  get_notice_list();
                });
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              )
            )
          ],
        ),
        body: show_list_notice(),
      ),
    );
  }

  Widget show_home_drawer(){
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                // แสดงไอคอน Team5
                show_bug_report_icon(),
                Align(
                 
                  child: Column(
                    children: [
                      // แสดงข้อมูลผู้พัฒนาแอปพลิเคชัน
                      SizedBox(height: 0),
                      show_dev_detail(),
                      // แสดงอีเมลผู้พัฒนาแอปพลิเคชัน
                      SizedBox(height: 5),
                      show_dev_email(),
                    ]
                  ),
                ),
              ],
            ),
            height: 170,
            color: Color.fromARGB(255, 90, 96, 102),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              // height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromARGB(255, 59, 134, 255),
              ),
              child: ListTile(
                title: const Text('จัดการปัญหาแอปพลิเคชัน', textAlign: TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.normal, fontFamily: 'CSPraKas',color: Colors.white)),
                onTap: () {
                  setState(() {
                    notice_list = [];
                    get_notice_list();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.bottomCenter,
                child:  
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 236, 82, 82)),
                    padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(75, 11, 75, 11)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide.none
                      )
                    )
                  ),
                  onPressed: () {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  }, 
                  child: Text("ออกจากระบบ" ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, fontFamily: 'CSPraKas',color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget show_bug_report_icon(){
    return Image.asset('assets/images/bug_report_icon.png', width: 100, height: 100);
  }

  Widget show_dev_detail(){
    return Padding(
      padding: const EdgeInsets.only(left:0,bottom:5),
      child: Text("${mem_firstname} ${mem_lastname}", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'CSPraKas')),
    );
  }

  Widget show_dev_email(){
    return Padding(
      padding: const EdgeInsets.only(left:0,bottom:5),
      child: Text("E-mail:${mem_email}", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'CSPraKas')),
    );
  }

  Widget show_list_notice(){
    return ListView.builder(
      itemCount: notice_list.length,
      itemBuilder: (context, index) {
        return Card(
          color: Color.fromARGB(255, 255, 255, 255),
          child: ListTile(
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 64,
                maxHeight: 64,
              ),
              child: Image.asset('assets/images/white_paper.jpeg', fit: BoxFit.cover),
            ),
            title: Text("${notice_list[index]['no_topic']}", style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold, fontFamily: 'CSPraKas') ,overflow: TextOverflow.ellipsis,),
            subtitle: Text("${notice_list[index]['no_description']}",style: TextStyle(fontSize: 16 , fontFamily: 'CSPraKas') , overflow: TextOverflow.ellipsis,),
             trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  margin: EdgeInsets.only(left: 5,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color.fromARGB(255, 230, 104, 104),
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.delete), 
                    color: Colors.black,
                    onPressed: () => set_delete_notice(notice_list[index]['no_id']),
                  ), 
                ),
                Container(
                  margin: EdgeInsets.only(left: 15,),
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color.fromARGB(255, 101, 160, 255),
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.remove_red_eye_rounded), 
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoticePage(
                            notice_list[index]['mem_id'],
                            notice_list[index]['no_id'],
                            notice_list[index]['no_topic'],
                            notice_list[index]['no_description'],
                            notice_list[index]['no_firstname'],
                            notice_list[index]['no_lastname'],
                            notice_list[index]['no_date_time'],
                            notice_list[index]['app_name']
                          ),
                        )
                      ).then((value) {
                        setState(() {
                          notice_list = [];
                          get_notice_list();
                        });
                      });
                    }, 
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoticePage(
                            notice_list[index]['mem_id'],
                            notice_list[index]['no_id'],
                            notice_list[index]['no_topic'],
                            notice_list[index]['no_description'],
                            notice_list[index]['no_firstname'],
                            notice_list[index]['no_lastname'],
                            notice_list[index]['no_date_time'],
                            notice_list[index]['app_name']
                  ),
                )
              ).then((value) {
                setState(() {
                  notice_list = [];
                  get_notice_list();
                });
              });
            },
        ));
      },
    );
  }

  // ดึงข้อมูล
  Future get_notice_list() async {
    String id = mem_id;

    // ร้องขอการเชื่อมต่อกับฐานข้อมูล
    var url = Uri.https('informatics.buu.ac.th', '/team5/mobile_query/get_notice.php');
    var data = {'id': id,'tokens' : 'ZSmrxIODdQ'};
    var response = await http.post(url, body: json.encode(data));
    var result = json.decode(response.body);
    setState(() {
      notice_list = result;
    });
    // print(result);
  }

  Future set_delete_notice(var no_id) async {
    // ร้องขอการเชื่อมต่อกับฐานข้อมูล
    var url = Uri.https('informatics.buu.ac.th', '/team5/mobile_query/del_notice.php');
    var data = {'no_id': no_id, 'mem_id': mem_id, 'no_status_id': 3,'tokens' : 'ZSmrxIODdQ'};
    var response = await http.post(url, body: json.encode(data));
    var result = json.decode(response.body);
    print(result);
    if(result == 'success'){
      setState(() {
        notice_list = [];
        get_notice_list();
      });
    }else if(result == 'failed'){

    }
  }
}