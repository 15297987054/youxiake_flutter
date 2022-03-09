import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ListView.builder(itemBuilder: (context, index) {
      return StickyHeader(
        header: Container(
          height: 50.0,
          color: Colors.blueGrey[700],
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: Text('Header #$index',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        content: Container(
          child: Image.network('https://qimg4.youxiake.com/upload/202202/07/91fb8bf760125ccf.jpg', fit: BoxFit.cover,
            width: double.infinity, height: 200.0),
        ),
      );
    })
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}