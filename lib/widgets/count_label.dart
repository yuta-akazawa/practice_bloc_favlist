import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CountLabel extends StatefulWidget{
  final int favoriteCount;

  CountLabel({
    Key key,
    @required this.favoriteCount,
}) :
        assert(favoriteCount >= 0),
        super(key:key);

  @override
  CountLabelState createState() {
    return CountLabelState();
  }
}

class CountLabelState extends State<CountLabel>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      widget.favoriteCount.toString(),
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35,
        color: Colors.pink,
      ),
    );
  }

}