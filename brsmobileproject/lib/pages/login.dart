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
  var db_email = ['dev01@hotmail.com', 'dev02@hotmail.com', 'dev03@hotmail.com'];
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
                Container(height: 100, width: 100,),

                // แสดงรูปภาพ BRS
                SizedBox(height: 20,),
                show_bug_report_image(),

                // แสดงข้อความ 'เข้าสู่ระบบ' 
                SizedBox(height: 20,),
                show_login_text(),

                // แสดงกล่องกรอกข้อมูล 'ชื่อผู้ใช้งาน' 
                SizedBox(height: 20,),
                show_username_textfield(),

                // แสดงกล่องกรอกข้อมูล 'รหัสผ่าน' 
                SizedBox(height: 20,),
                show_password_textfield(),

                // แสดงข้อความ 'เข้าสู่ระบบไม่สําเร็จ' 
                SizedBox(height: 20,),
                show_login_failed(),

                // แสดงปุ่ม 'เข้าสู่ระบบ'
                SizedBox(height: 20,),
                show_login_button(),

                Row(
                  children: [
                    // แสดงรูปภาพ Team5
                    show_credit_image(),
                
                    // แสดงข้อความ Team5
                    show_credit_text(),
                  ],
                )
              ],
            )),      
        ),
      ),
    );
  }

  Widget show_bug_report_image(){
    return Image.asset('assets/images/bug_report_image.png', width: 50, height: 50,);
  }

  Widget show_login_text(){
    return Text("เข้าสู่ระบบ", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'CSPraKas'),);
  }

  Widget show_username_textfield(){
    return TextField(
      controller: dev_username,
      decoration: InputDecoration(
        labelText: 'ชื่อผู้ใช้งาน', 
        border: OutlineInputBorder()
      ),
    );
  }
  
  Widget show_password_textfield(){
    return TextField(
      controller: dev_password,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'รหัสผ่าน', 
        border: OutlineInputBorder()
      ),
    );
  }

  Widget show_login_button(){
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      onPressed: () {
        // การเข้าสู่ระบบ
        var login_status = 'failed';
        var count = 0; 
        if(dev_username.text.isEmpty || dev_password.text.isEmpty){
          // กรอกข้อมูลไม่ครบถ้วน
          setState(() {
            dev_password.text = '';
            login_failed_message = 'กรุณากรอกชื่อผู้ใช้งานและรหัสผ่านให้ครบถ้วน';
          });
        }else if(dev_username.text.isNotEmpty && dev_password.text.isNotEmpty){
          // ตรวจสอบการเข้าสู่ระบบ
          while(count<db_username.length){
            if((dev_username.text == db_username[count]) && (dev_password.text == db_password[count])){
              // success
              login_status = 'success';
              break;
            }else if((dev_username.text != db_username[count]) || (dev_password.text != db_password[count])){
              // failed
              count++;
            }
          }
                  
          // เข้าสู่ระบบไม่สําเร็จ
          if(login_status == 'failed'){
            setState(() {
              dev_password.text = '';
              login_failed_message = 'ชื่อผู้ใช้งานหริอรหัสผ่านไม่ถูกต้อง';
            });
          }
          // เข้าสู่ระบบสําเร็จ
          else if(login_status == 'success'){ 
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => HomePage(db_firstname[count], db_lastname[count], db_email[count]),
              ),
            );
          }
        }
      },
      child: Text('เข้าสู่ระบบ'),
    );
  }

  Widget show_credit_image(){
    return  Image.asset('assets/images/team5_image.jpg', width: 20, height: 20,);
  }

  Widget show_credit_text(){
    return Text("BY TEAM 5", style: TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'CSPraKas'),);
  }
  
  Widget show_login_failed(){
    return Text("${login_failed_message}", style: TextStyle(color: Colors.red, fontSize: 10, fontFamily: 'CSPraKas'),);
  }
}