import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> navigationIconImage = [
  'assets/images/logo.png',
  'assets/images/Vector.png',
  'assets/images/Icon.png',
  'assets/images/Union.png',
];

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Color(0XFF18171C),
        border: Border(top: BorderSide(color: Color(0XFF2C2D31), width: 1.0)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(navigationIconImage[0], 'Home', true),
          _buildNavItem(navigationIconImage[1], 'News', false),
          _buildNavItem(navigationIconImage[2], 'TrackBox', false),
          _buildNavItem(navigationIconImage[3], 'Projects', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(String iconImage, String label, bool isActive) {
    return SizedBox(
      width: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isActive)
            Positioned(
              top: 0,
              child: Image.asset(
                "assets/images/ellipse.png",
                width: 14,
                height: 7,
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconImage, width: 23, height: 23),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.syne(
                  fontSize: 11,
                  color: isActive ? Colors.white : const Color(0XFF61616B),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
