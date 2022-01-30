import 'dart:async';
import 'package:flutter/material.dart';
import 'RootPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransitionPage extends StatefulWidget {
  @override
  _TransitionPageState createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  int _countDown = 1;
  late Timer _timer;
  @override
  void initState() { 
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _countDown--;
      });
      if(_countDown<=0){
        _jumpToPage();
      }
     });
  }
  _jumpToPage(){
    _timer.cancel();
    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(
        builder: (BuildContext context) => RootPage()
      )
    , (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
          designSize: Size(375, 667),
          context: context,
          minTextAdapt: true,
          orientation: Orientation.portrait
        );
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/ads.jpg',
            fit:BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: InkWell(
              child: _clipButton(),
              onTap: _jumpToPage,
            ),
          ),
        ],
      ),
    );
  }
  Widget _clipButton(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('跳过',style: TextStyle(fontSize: 12,color:Colors.white),),
            Text('${_countDown}s',style: TextStyle(fontSize: 12,color:Colors.white),)
          ],
        ),
      ),
    );
  }
}