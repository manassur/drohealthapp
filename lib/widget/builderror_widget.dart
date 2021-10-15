import 'package:flutter/material.dart';

class BuildError extends StatefulWidget {
  const BuildError({Key? key}) : super(key: key);

  @override
  _BuildErrorState createState() => _BuildErrorState();
}

class _BuildErrorState extends State<BuildError> {
  @override
  Widget build(BuildContext context) {
    return Center (
      child: Text ( "message something" , style: TextStyle ( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20 ) ,
      ) ,
    );  }
}
