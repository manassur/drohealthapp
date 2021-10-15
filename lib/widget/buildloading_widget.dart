import 'package:flutter/material.dart';

class BuildLoading extends StatefulWidget {
  const BuildLoading({Key? key}) : super(key: key);

  @override
  _BuildLoadingState createState() => _BuildLoadingState();
}

class _BuildLoadingState extends State<BuildLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFFA985))),
      ),
    );
  }
}
