import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:brsmobileproject/pages/login.dart';
import 'package:brsmobileproject/pages/notice.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  final db_firstname, db_lastname, db_email;
  HomePage(this.db_firstname, this.db_lastname, this.db_email);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dev_firstname; 
  var dev_lastname;
  var dev_email;

  List notice_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dev_firstname = widget.db_firstname;
    dev_lastname = widget.db_lastname;
    dev_email = widget.db_email;

    get_notice();
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
                  get_notice();
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
            child: Row(
              children: [
                // แสดงไอคอน Team5
                show_bug_report_icon(),
                Column(
                  children: [
                    // แสดงข้อมูลผู้พัฒนาแอปพลิเคชัน
                    SizedBox(height: 22),
                    show_dev_detail(),
                    // แสดงอีเมลผู้พัฒนาแอปพลิเคชัน
                    SizedBox(height: 5),
                    show_dev_email(),
                  ]
                ),
              ],
            ),
            height: 110,
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
                    get_notice();
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
    return Image.asset('assets/images/bug_report_icon.png', width: 100, height: 100,);
  }

  Widget show_dev_detail(){
    return Padding(
      padding: const EdgeInsets.only(top: 8,right: 37),
      child: Text("${dev_firstname} ${dev_lastname}", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'CSPraKas'),),
    );
  }

  Widget show_dev_email(){
    return Padding(
      padding: const EdgeInsets.only(left:2),
      child: Text("E-mail:${dev_email}", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'CSPraKas'),),
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
              child: Image.asset('assets/images/white_paper.png', fit: BoxFit.cover),
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
                    onPressed: () {
                    }, 
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
                          builder: (context) => NoticePage(),
                        )
                      ).then((value) {
                        setState(() {
                          notice_list = [];
                          get_notice();
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
                  builder: (context) => NoticePage(),
                )
              ).then((value) {
                setState(() {
                  notice_list = [];
                  get_notice();
                });
              });
            },
        ));
      },
    );
  }

  // ดึงข้อมูล
  Future get_notice() async {
    var url = Uri.https(
        'raw.githubusercontent.com', '/Sirawit62160162/BasicAPI/main/notice.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    setState(() {
      notice_list = result;
    });
  }
}