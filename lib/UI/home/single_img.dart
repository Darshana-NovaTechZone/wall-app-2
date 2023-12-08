import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../db/sqldb.dart';
import '../../../font/font.dart';
import '../../Color/color.dart';

class SingleImage extends StatefulWidget {
  const SingleImage({super.key, required this.img, required this.index, required this.singleImg});
  final List img;
  final int index;
  final String singleImg;

  @override
  State<SingleImage> createState() => _SingleImageState();
}

class _SingleImageState extends State<SingleImage> {
  final String imageUrl =
      "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg";
  final String folderName = 'MyImages';
  bool isDownloading = false;
  bool processing = false;
  bool share = false;
  static const _url =
      "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg";
  var random = Random();
  List img = [];
  int selectedImg = 0;
  String singleImg = '';
  SqlDb sqlDb = SqlDb();
  List localImg = [];
  List downloadImg = [];
  @override
  void initState() {
    localData();

    setState(() {
      img = widget.img;
      selectedImg = widget.index;
      singleImg = widget.singleImg;
    });
    super.initState();
  }

  localData() async {
    List res = await SqlDb().readData('select * from favorites');
    List resp = await SqlDb().readData('select * from download');
    setState(() {
      localImg = res;
      downloadImg = resp;
      print(downloadImg);
      print(res);
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: white,
        ),
        backgroundColor: fontBlue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: white,
            )),
        centerTitle: true,
        title: Text("RainFroest Wallpapers",
            style: TextStyle(
              color: white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                addWallpaper(context);
              },
              icon: Icon(Icons.app_shortcut_rounded)),
          IconButton(
              onPressed: () {
                info(context);
              },
              icon: Icon(Icons.info_outline))
        ],
      ),
      body: SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            Container(
                height: h,
                width: w,
                child: CarouselSlider.builder(
                  itemCount: img.length,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedImg = index;
                        singleImg = img[index]['name'];
                        print(selectedImg);
                      });
                    },
                    autoPlay: false,
                    viewportFraction: 1,
                    initialPage: selectedImg,
                    height: h,
                  ),
                  itemBuilder: (context, index, realIdx) {
                    return Stack(
                      children: [
                        Image.asset(img[index]['name'], fit: BoxFit.cover, height: h, width: w),
                        Container(
                          height: h,
                          width: w,
                          color: Colors.black.withOpacity(0.4),
                        )
                      ],
                    );
                  },
                )),
            isDownloading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(color: bacground, borderRadius: BorderRadius.circular(10)),
                        height: h / 6,
                        width: w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            CircularProgressIndicator(color: blue, strokeWidth: 5),
                            Spacer(
                              flex: 2,
                            ),
                            Text(
                              "Please waite...",
                              style: TextStyle(
                                fontSize: 18,
                                color: black2,
                                fontFamily: font,
                              ),
                            ),
                            Spacer(
                              flex: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white24,
                onTap: () async {
                  if (localImg.any((element) => element['img'] == selectedImg)) {
                    await SqlDb().deleteData('DELETE FROM favorites where img ="$selectedImg" ');
                  } else {
                    await SqlDb().insertData('insert into favorites ("img","name") values("$selectedImg","$singleImg")');
                  }

                  localData();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                      alignment: Alignment.center,
                      height: h / 14,
                      width: w / 4,
                      child: Icon(
                        localImg.any((element) => element['img'] == selectedImg) ? Icons.favorite : Icons.favorite_border,
                        color: localImg.any((element) => element['img'] == selectedImg) ? Colors.red : fontColor,
                      )),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white24,
                onTap: () {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  if (downloadImg.any((element) => element['img'] == singleImg)) {
                    scaffoldMessenger.showSnackBar(SnackBar(
                      content: Text(
                        'Image already downloaded',
                        style: TextStyle(
                          fontSize: 12,
                          color: black3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: white,
                    ));
                  } else {
                    imageSave(context, singleImg);
                  }
                  print(selectedImg);
                  // _saveImage(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                      alignment: Alignment.center,
                      height: h / 14,
                      width: w / 4,
                      child: Icon(
                        downloadImg.any((element) => element['img'] == singleImg) ? Icons.check_circle_outline : Icons.download,
                        color: fontColor,
                      )),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white24,
                onTap: () async {
                  setState(() {
                    share = true;
                    isDownloading = true;
                  });
                  final directory = await getExternalStorageDirectory();

                  final url = Uri.parse(imageUrl);
                  final response = await http.get(url);
                  var ss = await File('${directory!.path}myItem.png').writeAsBytes(response.bodyBytes);
                  print(ss);
                  setState(() {
                    isDownloading = false;
                    share = false;
                  });
                  await FlutterShare.shareFile(title: 'Compartilhar comprovante', filePath: ss.path, fileType: 'image/png');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                      alignment: Alignment.center,
                      height: h / 14,
                      width: w / 4,
                      child: Icon(
                        Icons.share,
                        color: fontColor,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setWallpaper(int? selectedOption, BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    setState(() {
      share = true;
      isDownloading = true;
    });
    final directory = await getExternalStorageDirectory();

    final url = Uri.parse(imageUrl);
    final response = await http.get(url);
    var path = await File('${directory!.path}${DateTime.now().millisecondsSinceEpoch}').writeAsBytes(response.bodyBytes);
    print(path);

    if (selectedOption == 1) {
      int location = await WallpaperManager.HOME_SCREEN;
      print(location); //can be Home/Lock Screen
      bool result = await WallpaperManager.setWallpaperFromFile(path.path, location);
    } else if (selectedOption == 2) {
      // await WallpaperManager.clearWallpaper();
      int location = await WallpaperManager.LOCK_SCREEN;
      print(location); //can be Home/Lock Screen
      bool result = await WallpaperManager.setWallpaperFromFile(path.path, location);
    }
    setState(() {
      share = false;
      isDownloading = false;
    });
    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(
        'wallpaper successfully added',
        style: TextStyle(
          fontSize: 12,
          color: black3,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: white,
    ));
  }

  addWallpaper(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        showDragHandle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: bacground,
        context: context,
        builder: (context) {
          return Container(
            width: w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  onTap: () {
                    setWallpaper(2, context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: h / 12,
                    child: Text(
                      'Set as Lock Screen Wallpaper',
                      style: TextStyle(color: black1, fontSize: 18),
                    ),
                  ),
                ),
                Divider(
                  color: black3,
                  height: 0,
                ),
                InkWell(
                  onTap: () {
                    setWallpaper(1, context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: h / 12,
                    child: Text(
                      'Set as Home Screen Wallpaper',
                      style: TextStyle(color: black1, fontSize: 18),
                    ),
                  ),
                ),
                Divider(
                  color: black3,
                  height: 0,
                ),
                InkWell(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: h / 12,
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: black1, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  info(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: bacground,
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  child: Text(
                    "Info",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: black1,
                      fontFamily: font,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: w / 3,
                      child: Text(
                        "Resolution",
                        style: TextStyle(
                          fontSize: 18,
                          color: black2,
                          fontFamily: font,
                        ),
                      ),
                    ),
                    Text(
                      "720*1600",
                      style: TextStyle(
                        fontSize: 18,
                        color: black2,
                        fontFamily: font,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: w / 3,
                      child: Text(
                        "Size",
                        style: TextStyle(
                          fontSize: 18,
                          color: black2,
                          fontFamily: font,
                        ),
                      ),
                    ),
                    Text(
                      "0.8668 MB",
                      style: TextStyle(
                        fontSize: 18,
                        color: black2,
                        fontFamily: font,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: w / 3,
                      child: Text(
                        "Views",
                        style: TextStyle(
                          fontSize: 18,
                          color: black2,
                          fontFamily: font,
                        ),
                      ),
                    ),
                    Text(
                      "24.4k",
                      style: TextStyle(
                        fontSize: 18,
                        color: black2,
                        fontFamily: font,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: w / 3,
                      child: Text(
                        "Download",
                        style: TextStyle(
                          fontSize: 18,
                          color: black2,
                          fontFamily: font,
                        ),
                      ),
                    ),
                    Text(
                      "1.9k",
                      style: TextStyle(
                        fontSize: 18,
                        color: black2,
                        fontFamily: font,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  imageSave(BuildContext context, String img) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    late String message;
    setState(() {
      isDownloading = true;
    });
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${DateTime.now()}.jpg';
    await Dio().download(_url, path);
    await GallerySaver.saveImage(path, albumName: 'wallpaper');
    setState(() {
      isDownloading = false;
    });
    message = e.toString();
    await SqlDb().insertData('insert into download ("img") values("$img")');
    localData();
    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(
        'Image successfully saved',
        style: TextStyle(
          fontSize: 12,
          color: black3,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: white,
    ));
  }
}
