import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallpaper_app_2/Color/color.dart';
import 'package:wallpaper_app_2/UI/home/home.dart';

class Onbord extends StatefulWidget {
  const Onbord({super.key});

  @override
  State<Onbord> createState() => _OnbordState();
}

class _OnbordState extends State<Onbord> {
  bool? isCheck = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blue,
      body: SizedBox(
        width: w,
        height: h,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Rainforest Wallpapers",
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                  )),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: h / 9,
                child: Image.asset(
                  'assets/icon.PNG',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Wrap(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: Checkbox(
                      side: BorderSide(width: 2, color: white),
                      checkColor: fontBlue, // color of tick Mark
                      activeColor: white,
                      focusColor: white,
                      value: isCheck,
                      onChanged: (value) {
                        setState(() {
                          isCheck = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: w / 1.3,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          'I have read and agree to the ',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: white, fontWeight: FontWeight.normal, fontSize: 14, fontFamily: 'Exo2'),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Terms of Service ',
                            style: TextStyle(
                                color: fontBlue,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                fontFamily: 'Exo2',
                                decoration: TextDecoration.underline,
                                decorationColor: fontBlue),
                          ),
                        ),
                        Text(
                          '& ',
                          style: TextStyle(color: white, fontWeight: FontWeight.normal, fontSize: 14, fontFamily: 'Exo2'),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Privacy Policy ',
                            style: TextStyle(
                                color: fontBlue,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                fontFamily: 'Exo2',
                                decoration: TextDecoration.underline,
                                decorationColor: fontBlue),
                          ),
                        ),
                        Text(
                          'before using this app',
                          style: TextStyle(color: white, fontWeight: FontWeight.normal, fontSize: 14, fontFamily: 'Exo2'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(type: PageTransitionType.rightToLeft, child: Home(), inheritTheme: true, ctx: context),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: w / 4,
                            child: CustomPaint(
                              size: Size(
                                  w / 8,
                                  (w / 5)
                                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: RPSCustomPainter(),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                size: 33,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text("Get Started",
                  style: TextStyle(
                    color: white,
                    fontSize: 22,
                  )),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4996000, size.height * 0.0024000);
    path_0.lineTo(0, size.height * 0.4988000);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.9960000);
    path_0.lineTo(size.width * 0.9988000, size.height * 0.5016000);
    path_0.lineTo(size.width * 0.5020000, size.height * 0.0040000);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(0, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
