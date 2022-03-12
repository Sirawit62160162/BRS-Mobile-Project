import 'package:brsmobileproject/pages/home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dev_username = TextEditingController();
  final dev_password = TextEditingController();

  var login_failed_message;
  var focus_border_color = Color.fromARGB(255, 130, 214, 245);
  var enabled_border_color = Color.fromARGB(255, 255, 255, 255);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login_failed_message = '';
  }

  // Test Data
  var db_username = ['dev01', 'dev02', 'dev03'];
  var db_password = ['12301', '12302', '12303'];
  var db_firstname = ['ไตรทศ ', 'ธนาทิพย์', 'นฤเดช'];
  var db_lastname = ['สิริปัจทรัพย์', 'รุ่งทิพย์', 'เจริญสกุล'];
  var db_email = [
    'dev01@hotmail.com',
    'dev02@hotmail.com',
    'dev03@hotmail.com'
  ];
  // Test Data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_background_image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: ListView(
            children: [
              Container(
                height: 30,
                width: 100,
              ),

              // แสดงรูปภาพ BRS
              SizedBox(
                height: 20,
              ),
              show_bug_report_image(),

              // แสดงข้อความ 'เข้าสู่ระบบ'
              SizedBox(
                height: 20,
              ),
              show_login_text(),

              // แสดงกล่องกรอกข้อมูล 'ชื่อผู้ใช้งาน'
              SizedBox(
                height: 0,
              ),
              show_username_textfield(),

              // แสดงกล่องกรอกข้อมูล 'รหัสผ่าน'
              SizedBox(
                height: 10,
              ),
              show_password_textfield(),

              // แสดงข้อความ 'เข้าสู่ระบบไม่สําเร็จ'
              SizedBox(
                height: 15,
              ),
              show_login_failed(),

              // แสดงปุ่ม 'เข้าสู่ระบบ'
              SizedBox(
                height: 20,
              ),
              show_login_button(),

              // แสดงรูปภาพ Team5
              SizedBox(
                height: 30,
              ),
              show_credit(),
            ],
          )),
        ),
      ),
    );
  }

  Widget show_bug_report_image() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Image.asset(
        'assets/images/Bug_report_icon2.png',
        width: 217,
        height: 217,
      ),
    );
  }

  Widget show_login_text() {
    // return  TextButton(
    //   onPressed: check_user_login, 
    //   style: ButtonStyle(
    //     foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    //   ),
    //   child: Text('เข้าสู่ระบบ'),
    // );
    return Center(
        child: Text(
      "เข้าสู่ระบบ",
      style: TextStyle(
          color: Colors.black,
          fontSize: 31,
          fontWeight: FontWeight.bold,
          fontFamily: 'CSPraKas'),
    ));
  }

  Widget show_username_textfield() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
      child: TextField(
        controller: dev_username,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focus_border_color, width: 3.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabled_border_color, width: 3.0),
          ),
          contentPadding: EdgeInsets.all(8),
          hintText: 'ชื่อผู้ใช้งาน',
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 199, 197, 197),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'CSPraKas'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(fontSize: 22), 
      ),
    );
  }

  Widget show_password_textfield() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: TextField(
        controller: dev_password,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focus_border_color, width: 3.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enabled_border_color, width: 3.0),
            ),
            contentPadding: EdgeInsets.all(8),
            hintText: 'รหัสผ่าน',
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
                color: Color.fromARGB(255, 199, 197, 197),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'CSPraKas'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            )
        ),
        style: TextStyle(fontSize: 22,), 
      ),
    );
  }

  Widget show_login_button() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextButton(
        onPressed: () {
          // การเข้าสู่ระบบ
          var login_status = 'failed';
          var count = 0;
          if (dev_username.text.isEmpty || dev_password.text.isEmpty) {
            // กรอกข้อมูลไม่ครบถ้วน

            setState(() {
              dev_password.text = '';
              login_failed_message =
                  '  กรุณากรอกชื่อผู้ใช้งานและรหัสผ่านให้ครบถ้วน  ';
              focus_border_color = Color.fromARGB(255, 255, 93, 84);
              enabled_border_color = Color.fromARGB(255, 255, 93, 84);
            });
          } else if (dev_username.text.isNotEmpty &&
              dev_password.text.isNotEmpty) {
            // ตรวจสอบการเข้าสู่ระบบ
            while (count < db_username.length) {
              if ((dev_username.text == db_username[count]) &&
                  (dev_password.text == db_password[count])) {
                // success
                login_status = 'success';
                break;
              } else if ((dev_username.text != db_username[count]) ||
                  (dev_password.text != db_password[count])) {
                // failed
                count++;
              }
            }

            // เข้าสู่ระบบไม่สําเร็จ
            if (login_status == 'failed') {
              setState(() {
                dev_password.text = '';
                login_failed_message = '  ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง  ';
                focus_border_color = Color.fromARGB(255, 255, 93, 84);
                enabled_border_color = Color.fromARGB(255, 255, 93, 84);
              });
            }
            // เข้าสู่ระบบสําเร็จ
            else if (login_status == 'success') {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomePage(
                      db_firstname[count], db_lastname[count], db_email[count]),
                ),
              );
            }
          }
        },
        child: Text('เข้าสู่ระบบ',
            style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.bold,
                fontFamily: 'CSPraKas')),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            padding:
                MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 15, 50, 15)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide.none))),
      ),
    );
  }

  Widget show_credit() {
    return Padding(
      padding: const EdgeInsets.only(left: 138, top: 26),
      child: Center(
          child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/team5_image.jpg'),
                radius: 17,
              ),
              // Image.asset('assets/images/team5_image.jpg', width: 30, height: 30,),
              Text(
                " BY TEAM 5",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CSPraKas'),
              )
            ],
          )
        ],
      )),
    );
  }

  Widget show_login_failed() {
    return Center(
          child: Text(
            "${login_failed_message}",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
              fontFamily: 'CSPraKas',
              backgroundColor: Color.fromARGB(255, 255, 93, 84)),
      ));
  }

  // // ติดต่อฐานข้อมูลสําหรับเข้าสู่ระบบ
  // Future check_user_login() async {
  //   String username = dev_username.text;
  //   String password = dev_password.text;

  //   if(username.isEmpty || password.isEmpty){
  //     setState(() {
  //       dev_password.text = '';
  //       login_failed_message = 'กรุณากรอกชื่อผู้ใช้งานและรหัสผ่านให้ครบถ้วน';
  //     });
  //   }else if(username.isNotEmpty && password.isNotEmpty){
  //     // ร้องขอการเชื่อมต่อกับฐานข้อมูล (/loing_user_local.php, /login_user_server.php)
  //     var url = Uri.https('https://informatics.buu.ac.th', '/team5/login_user_local.php');
  //     var data = {'username': username, 'password': password};

  //     // เชื่อมต่อกับฐานข้อมูล 
  //     var response = await http.post(url, body: json.encode(data));
  //     var result = json.decode(response.body);
  //     print(result);
  //   }
  // }
}
