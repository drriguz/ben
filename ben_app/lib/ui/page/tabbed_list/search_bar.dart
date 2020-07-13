import '../../theme/icons.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 1.0, 30, 1),
        child: TextField(
          style: TextStyle(color: Colors.white, fontSize: 20.0),
          decoration: InputDecoration(
            prefixIcon: Icon(
              FontIcon.search,
              color: Colors.white,
              size: 22.0,
            ),
            filled: true,
            fillColor: Colors.white30,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white30),
              borderRadius: BorderRadius.circular(40.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white30),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
          ),
        ));
  }
}
