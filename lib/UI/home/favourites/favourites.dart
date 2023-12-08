import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallpaper_app_2/Color/color.dart';

import '../../../db/sqldb.dart';
import '../single_img.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  SqlDb sqlDb = SqlDb();
  List images = [];
  @override
  void initState() {
    localData();
    super.initState();
  }



  localData() async {
    List res = await SqlDb().readData('select * from favorites');
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffe4e7e7),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: white,
              )),
          iconTheme: IconThemeData(color: white),
          backgroundColor: fontBlue,
          centerTitle: true,
          title: Text("Images",
              style: TextStyle(
                color: white,
                fontSize: 22,
              )),
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
              itemCount: images.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: SingleImage(img: images, index: index, singleImg: images[index]['name']),
                            inheritTheme: true,
                            ctx: context),
                      );
                    },
                    child: Card(child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset(images[index]['name']))));
              },
            )));
  }
}
