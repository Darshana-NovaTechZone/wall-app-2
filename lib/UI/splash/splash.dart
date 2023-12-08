import 'package:flutter/material.dart';
import 'package:wallpaper_app_2/UI/onboarding/onbord.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // SqlDb sqlDb = SqlDb();
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Onbord(),
        )));
// ddd
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Image.asset(
        'assets/3.PNG',
        width: w,
        height: h,
        fit: BoxFit.cover,
      ),
    );
  }
}
