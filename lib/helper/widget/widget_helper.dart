
import 'package:flutter/material.dart';

class WidgetHelper {


  OutlineInputBorder outlineInputBorderTextFieldRounded(){
    OutlineInputBorder outlineInputBorder = new OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: Colors.white));
    return outlineInputBorder;
  }

  OutlineInputBorder outlineInputBorderTextFieldRoundedColor(){
    OutlineInputBorder outlineInputBorder = new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.blue));
    return outlineInputBorder;
  }

  OutlineInputBorder outlineInputBorderTextFieldRoundedEnabled(){
    OutlineInputBorder outlineInputBorder = new OutlineInputBorder(borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(20.0));
    return outlineInputBorder;
  }

}