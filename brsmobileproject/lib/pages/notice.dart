import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  // const NoticePage({ Key? key }) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จัดการปัญหาแอปพลิเคชัน'),
        actions: [
          
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Text('Hello'),
          ],
        ),
      ),
    );
  }
}