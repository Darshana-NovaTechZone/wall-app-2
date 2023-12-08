import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallpaper_app_2/Color/color.dart';
import 'package:wallpaper_app_2/UI/home/single_img.dart';

import '../wiget/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // SqlDb sqlDb = SqlDb();
  @override
  void initState() {
    super.initState();
  }

  List img = [
    {"name": "assets/1.PNG"},
    {"name": "assets/2.PNG"},
    {"name": "assets/3.PNG"},
    {"name": "assets/4.PNG"},
    {"name": "assets/5.PNG"},
    {"name": "assets/6.PNG"},
    {"name": "assets/7.PNG"},
    {"name": "assets/8.PNG"},
    {"name": "assets/9.PNG"},
    {"name": "assets/10.PNG"},
    {"name": "assets/11.PNG"},
    {"name": "assets/12.PNG"},
    {"name": "assets/13.PNG"},
    {"name": "assets/14.PNG"},
    {"name": "assets/15.PNG"},
    {"name": "assets/16.PNG"},
    {"name": "assets/17.PNG"},
  ];
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: CustomDrawer(),
        backgroundColor: Color(0xffe4e7e7),
        appBar: AppBar(
          iconTheme: IconThemeData(color: white),
          backgroundColor: fontBlue,
          centerTitle: true,
          title: Text("Images",
              style: TextStyle(
                color: white,
                fontSize: 22,
              )),
          toolbarHeight: 70,
          bottom: PreferredSize(
            preferredSize: Size(w, 70),
            child: Container(
              color: white,
              height: 70.0,
              width: w,
              child: Column(children: [
                Spacer(),
                Text("Rainforest Wallpaper",
                    style: TextStyle(
                      color: fontBlue,
                      fontSize: 17,
                    )),
                Spacer(),
                Container(
                  height: 5,
                  width: w / 2,
                  decoration:
                      BoxDecoration(color: fontBlue, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                ),
                SizedBox(
                  height: 8,
                )
              ]),
            ),
          ),
        ),
        body: SizedBox(
            width: w,
            child: MasonryGridView.count(
              padding: EdgeInsets.all(8),
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: img.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: SingleImage(img: img, index: index, singleImg: img[index]['name']),
                            inheritTheme: true,
                            ctx: context),
                      );
                    },
                    child: Card(child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset(img[index]['name']))));
              },
            )));
  }
}
