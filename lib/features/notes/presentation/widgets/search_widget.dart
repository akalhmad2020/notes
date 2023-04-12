
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key , required this.isItSearch , required this.onTap}) : super(key: key);
  final bool isItSearch ;
  final Function() onTap ;
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap  ,
      child: Container(
        width: 48,
        height: 48,
        decoration:   BoxDecoration(
          color:  Colors.white.withOpacity(0.05) ,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child:   Center(child: isItSearch  ? const Icon(Icons.search) : const Icon(Icons.check) ),
      ),
    );
  }
}