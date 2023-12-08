import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallpaper_app_2/UI/home/favourites/favourites.dart';

import '../../Color/color.dart';
import 'drawer_row.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final Uri _url = Uri.parse('https://novatechzone.lk/blog/');

  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Drawer(
        backgroundColor: white,
        //  Color.fromARGB(255, 73, 15, 105),
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w,
                  color: blue,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Image.asset('assets/icon.PNG'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Rainforest Wallpapers",
                            style: TextStyle(
                              color: white,
                              fontSize: 18,
                            )),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    DrawerRow(
                        icon: Icons.home,
                        text: 'Home',
                        on: () {
                          Navigator.pop(context);
                        }),
                    DrawerRow(
                        icon: Icons.favorite_border,
                        text: 'Favourites',
                        on: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.rightToLeft, child: Favorites(), inheritTheme: true, ctx: context),
                          );
                        }),
                    Divider(),
                    Text("About this App",
                        style: TextStyle(
                          color: black3,
                          fontSize: 12,
                        )),
                    DrawerRow(
                        icon: Icons.account_balance_wallet_rounded,
                        text: 'More Apps',
                        on: () {
                          Navigator.pop(context);
                        }),
                    DrawerRow(
                        icon: Icons.share,
                        text: 'Share The App',
                        on: () async {
                          await FlutterShare.share(title: 'Rainforest wallpaers \n www.novatechzone.com');
                          Navigator.pop(context);
                        }),
                    DrawerRow(
                        icon: Icons.thumb_up_alt,
                        text: 'Rate Us',
                        on: () {
                          // _launchUrl();
                        }),
                    DrawerRow(icon: Icons.question_mark_sharp, text: 'Feedback', on: () {}),
                    Divider(),
                    Text("About Us",
                        style: TextStyle(
                          color: black3,
                          fontSize: 12,
                        )),
                    DrawerRow(icon: Icons.groups_2, text: 'Terms of Service', on: () {}),
                    DrawerRow(icon: Icons.groups_2, text: 'Privacy policy', on: () {}),
                    DrawerRow(icon: Icons.groups_2, text: 'Disclaimer', on: () {}),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
