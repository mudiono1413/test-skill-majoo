import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ErrorScreen extends StatefulWidget {
  const ErrorScreen({ Key? key }) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.signal_wifi_connected_no_internet_4_rounded,
            color: Colors.red,
            size: 140.h,),
            Text("Tidak terhubung ke internet \n Silahkan hubungkan koneksi internet anda dan tunggu beberapa saat.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp
            ),)
          ],
        ),
      ),
    );
  }
}