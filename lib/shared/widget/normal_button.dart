import 'package:flutter/material.dart';
import 'package:my_shop/shared/animations/fade_animation.dart';
import 'package:my_shop/shared/style/styles.dart';

class NormalButton extends StatelessWidget {
  final bool isEnable;
  final String title;
  final VoidCallback onPressed;
  const NormalButton({
    Key key,
    @required this.title,
    @required this.isEnable,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: 2.0,
      child: Material(
        child: InkWell(
          onTap: isEnable ? onPressed : null,
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: isEnable
                  ? const LinearGradient(
                      colors: [
                        primaryColor,
                        primaryColor0_6,
                      ],
                    )
                  : LinearGradient(colors: [Colors.grey, Colors.grey[350]]),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
