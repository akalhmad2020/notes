

import 'package:flutter/material.dart';
import 'package:notes/features/notes/presentation/widgets/search_widget.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key , required this.isItSearch , required this.onTap}) : super(key: key);
  final bool isItSearch ;
  final Function() onTap ;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const  [
           Text('Notes' , style: TextStyle(fontSize: 28 , fontFamily: 'Poppins'), ) ,
           Spacer(),
       // SearchWidget(isItSearch: isItSearch , onTap: onTap ,),
      ],
    );
  }
}