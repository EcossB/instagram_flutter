import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instagram_flutter/utils/dimensions.dart';

class ReponsiveLayout extends StatelessWidget{
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ReponsiveLayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth > webScreenSize ){
          // web screen.
          return webScreenLayout;
        }
          //mobile screen.
          return mobileScreenLayout;
      }
    );
  }
}