import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:youxiake_project/utils/index.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child:  Center(
        child: LoadingAnimationWidget.beat(
          color: Util.hexColor(0xffd410),
          size: 50,
        ),
    ));
  }
}