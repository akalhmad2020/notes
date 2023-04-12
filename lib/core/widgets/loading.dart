

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theam.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(padding: const EdgeInsets.symmetric(vertical: 20) ,
    child: SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(color: secondaryColor,),
    ),);
  }
}
