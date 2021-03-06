import 'package:flutter/material.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget? child;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final Function onPressed;

  const RaisedGradientButton({Key? key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
          gradient: gradient, boxShadow: [
        BoxShadow(
          color: Color(0XFF7A08FA),
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed(),
            child: Center(
              child: child,
            )),
      ),
    );
  }
}