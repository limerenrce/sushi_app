import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/components/button.dart';
import 'package:sushi_app/theme/colors.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 25,
                ),

                //SHOP NAME
                Text(
                  "SUBARASHI SUSHI",
                  style: GoogleFonts.dmSerifDisplay(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 60),

                //ICON
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/sushi_intro.png'),
                ),

                //TITLE
                Text(
                  'THE TASTE OF JAPANESE FOOD',
                  style: GoogleFonts.dmSerifDisplay(
                    fontSize: 44,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                //SUBTITLE
                Text(
                  "Feel the taste of the most popular Japanese food from anywhere and anytime",
                  style: TextStyle(
                    color: Colors.grey[200],
                    height: 2,
                  ),
                ),
                const SizedBox(height: 40),

                //GET STARTED BUTTON
                MyButton(
                  text: "Get Started",
                  onTap: () {
                    //GO TO MENU PAGE
                    Navigator.pushNamed(context, '/main-page');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
