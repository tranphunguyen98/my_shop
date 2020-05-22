import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(129, 133, 226, 1);
const primaryColor0_3 = Color.fromRGBO(129, 133, 226, .3);
const primaryColor0_6 = Color.fromRGBO(129, 133, 226, .6);

const kTextStyleTitleNormal = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const kTextStyleTitleLarge = TextStyle(
  color: Colors.white,
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

const kTextStyleTitleXLarge = TextStyle(
  color: Colors.white,
  fontSize: 40,
  fontWeight: FontWeight.bold,
);

const kTextStyleSubtitleNormal = TextStyle(
  fontSize: 16,
  color: Colors.white,
);

const kTextHint = TextStyle(
  color: Color(0xFFBDBDBD),
);

final BoxDecoration kBoxDecorationNormal = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      color: primaryColor0_3,
      blurRadius: 20.0,
      offset: Offset(0, 10),
    )
  ],
);

const kBoxDecorationBottom = BoxDecoration(
  border: Border(
    bottom: BorderSide(
      color: Color(0xFFF5F5F5),
    ),
  ),
);
