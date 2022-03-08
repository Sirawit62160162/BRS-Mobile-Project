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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dev_firstname = widget.db_firstname;
    dev_lastname = widget.db_lastname;
    dev_email = widget.db_email;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 0,
      child: Scaffold(
        drawer: show_home_drawer(),
        appBar: AppBar(
          // ปุ่มรีเฟรช
        ),
        body: Column(
          children: [
            NoticePage(),
          ],
        ),
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
                Row(
                  children: [
                    // แสดงไอคอน Team5
                    show_bug_report_icon(),

                    // แสดงข้อมูลผู้พัฒนาแอปพลิเคชัน
                    show_dev_detail()
                  ]
                ),
                // แสดงอีเมลผู้พัฒนาแอปพลิเคชัน
                show_dev_email(),
              ],
            ),
            height: 100,
            color: Colors.blue,
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('จัดการปัญหาแอปพลิเคชัน'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
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
    return Image.asset('assets/images/bug_report_icon.png', width: 50, height: 50,);
  }

  Widget show_dev_detail(){
    return Text("${dev_firstname} ${dev_lastname}", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'CSPraKas'),);
  }

  Widget show_dev_email(){
    return Text("${dev_email}", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'CSPraKas'),);
  }

}