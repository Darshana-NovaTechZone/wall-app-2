import 'package:flutter/material.dart';
import 'package:wallpaper_app_2/Color/color.dart';
import 'package:wallpaper_app_2/font/font.dart';

class DrawerRow extends StatelessWidget {
  const DrawerRow({super.key, required this.text, required this.on, required this.icon});
  final String text;
  final VoidCallback on;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: on,
      borderRadius: BorderRadius.circular(0),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: black1,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: font,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
