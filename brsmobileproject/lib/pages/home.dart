import 'package:brsmobileproject/pages/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dev_firstname; 
  var dev_lastname;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        drawer: show_home_drawer(),
        appBar: AppBar(
          // ปุ่มรีเฟรช
        ),
        body: Column(
          children: [
            Text("Test"),
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
            child: Row(
              children: [
                // แสดงไอคอน Team5
                show_bug_report_icon(),

                // แสดงข้อมูลผู้พัฒนาแอปพลิเคชัน
                show_dev_detail()
              ]
            ),
            height: 100,
            color: Colors.blue,
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('Form 1'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('Form 2'),
            onTap: () {},
          ),
          Expanded(
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
        ],
      ),
    );
  }

  Widget show_bug_report_icon(){
    return Image.asset('assets/images/bug_report_icon.png', width: 50, height: 50,);
  }

  Widget show_dev_detail(){
    dev_firstname = "สิรวิชญ์";
    dev_lastname = "ฐิติสุนทรลักษณ์";
    return Text("${dev_firstname} ${dev_lastname}", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'CSPraKas'),);
  }
}