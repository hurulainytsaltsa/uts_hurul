import 'package:flutter/material.dart';
import 'package:uts_hurul/screen_page/page_login.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({super.key});

  @override
  State<PageSplash> createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PageLogin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white38,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('gambar/img.png',
                  fit: BoxFit.contain,
                  height: 150,
                  width: 150,),
                SizedBox(height: 8),
                Text('Politeknik Negeri Padang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Limau Manis, Kec. Pauh, Kota Padang, Sumatera Barat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,)
                )
              ]
          )
      ),
    );
  }
}
