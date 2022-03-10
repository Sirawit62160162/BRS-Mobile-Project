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
        drawer: show_home_drawer(),
        appBar: AppBar(
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
                    SizedBox(height: 20),
                    show_dev_detail(),
                    // แสดงอีเมลผู้พัฒนาแอปพลิเคชัน
                    SizedBox(height: 20),
                    show_dev_email(),
                  ]
                ),
              ],
            ),
            height: 100,
            color: Colors.blue,
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color.fromARGB(255, 58, 78, 255),
            ),
            alignment: Alignment.center,
            child: ListTile(
              title: const Text('จัดการปัญหาแอปพลิเคชัน'),
              onTap: () {
                setState(() {
                  notice_list = [];
                  get_notice();
                });
                Navigator.of(context).pop();
              },
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child:  
              TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () {
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => LoginPage(),
                    ),
                  );
                }, 
                child: Text("ออกจากระบบ"),
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
    return Text("${dev_firstname} ${dev_lastname}", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'CSPraKas'),);
  }

  Widget show_dev_email(){
    return Text("${dev_email}", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'CSPraKas'),);
  }

  Widget show_list_notice(){
    return ListView.builder(
      itemCount: notice_list.length,
      itemBuilder: (context, index) {
        return Card(
          color: Color.fromARGB(255, 161, 140, 139),
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
            title: Text("${notice_list[index]['no_topic']}", style: TextStyle(fontWeight: FontWeight.bold) ,overflow: TextOverflow.ellipsis,),
            subtitle: Text("${notice_list[index]['no_description']}", overflow: TextOverflow.ellipsis,),
             trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color.fromARGB(255, 110, 109, 109),
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.delete), 
                    onPressed: () {
                    }, 
                  ), 
                ),
                Container(
                  margin: EdgeInsets.only(left: 15,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color.fromARGB(255, 110, 109, 109),
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.remove_red_eye_rounded), 
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