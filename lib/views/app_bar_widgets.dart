import 'package:flutter/material.dart';

class AppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidgets({super.key, required this.leftIcon});
  final Widget leftIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1C1B1F),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 13.98, top: 17.48),
              child: leftIcon,
            ),
            Column(
              children: [
                Image.asset('assets/logo_app.png', width: 115, height: 76.99),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 83,
                    top: 10,
                    right: 83,
                    bottom: 21,
                  ),
                  child: Text(
                    'RICK AND MORTY API',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.5,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.23, right: 13.98),
              child: Icon(Icons.person_2, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(130.92);
}
