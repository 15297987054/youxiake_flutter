import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin {
  List _waterFallList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var randomNum = new Random();
    for(var i=0;i<40;i++){
      _waterFallList.add(50+150*randomNum.nextDouble());
    }
    print(_waterFallList);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
        child: MasonryGridView.count(
                // 展示几列
                crossAxisCount: 3,
                // 元素总个数
                itemCount: _waterFallList.length,
                // 单个子元素
                itemBuilder: (BuildContext context, int index) => waterCard(_waterFallList[index]),
                // 纵向元素间距
                mainAxisSpacing: 10,
                // 横向元素间距
                crossAxisSpacing: 10,
                //本身不滚动，让外面的singlescrollview来滚动
                physics:const NeverScrollableScrollPhysics(), 
                shrinkWrap: true, //收缩，让元素宽度自适应
              ),
      ),
    );
  }
  Widget waterCard(double item){
    return Container(
      height: item,
      decoration: BoxDecoration(
        border:Border.all(color:Colors.yellow,width:1),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text(item.toStringAsFixed(0)),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}