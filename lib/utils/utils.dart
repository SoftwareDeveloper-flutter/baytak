import 'package:flutter/material.dart';

class Utils{
  static void fieldFocus(BuildContext context,FocusNode currentFocusNode, FocusNode nextFocusNode){
    currentFocusNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);

  }
}