import 'package:flutter/material.dart';

class AppUtil extends StatelessWidget {
  const AppUtil({Key? key}) : super(key: key);

  static BoxDecoration getDecoration(double radius, Color boxColor) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: boxColor,
    );
  }

  static Text appText(String text, Color color, double fontSize, bool isBold) {
    return isBold==false ? Text(text, style: TextStyle(color: color, fontSize: fontSize),) :
      Text(text, style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold),);
  }

  static TextStyle appTextStyle(Color color, double fontSize, bool isBold) {
    return isBold==false ? TextStyle(color: color, fontSize: fontSize,) :
      TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold);
  }

  static String hideDigits(int number) {
    final numberString = number.toString();
    String hiddenString = '';
    const bullet = '\u2022'; // bullet character
    for(int i=1;i<=numberString.length-4;i++) {
      hiddenString+=bullet;
      if(i%4==0 && i>0) {
        hiddenString+=' ';
      }
    }
    return hiddenString + numberString.substring(numberString.length-4, numberString.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
