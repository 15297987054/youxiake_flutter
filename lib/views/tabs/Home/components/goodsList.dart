import 'package:flutter/material.dart';
import 'package:youxiake_project/components/goodsCard.dart';
import 'package:youxiake_project/utils/index.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GoodsList extends StatefulWidget {
  List data = [];
  List goodsList = [];
  Function getData;
  GoodsList(
      {Key? key,
      required this.data,
      required this.goodsList,
      required this.getData})
      : super();
  @override
  _GoodsListState createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> {
  int type = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._initdata();
  }

  void _initdata() {
    if (widget.data.length > 0) {
      this.setState(() {
        type = widget.data[0].type;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List data = widget.data;
    List goodsList = widget.goodsList;
    if (data.length == 0 || goodsList.length == 0) return SizedBox();
    return Container(
      child: Column(
        children: [
          // tabs area
          Container(
              height: Util.sw(20),
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: data.map<Widget>((item) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        item['type'] == type
                            ? Positioned(
                                top: 0,
                                child: Image.network(
                                    'https://m.youxiake.com/img/index_nav_a.f046aa77.png?t=f046aa77a05058f6e5e279318b243a74',
                                    width: Util.sw(40),
                                    height: Util.sw(25),
                                    fit: BoxFit.fill))
                            : SizedBox(),
                        Container(
                          padding: EdgeInsets.only(
                              left: Util.sw(10), right: Util.sw(10)),
                          child: Text(item['typeName'],
                              style: TextStyle(
                                color: item['type'] == type
                                    ? Util.hexColor(0x333333)
                                    : Util.hexColor(0x000000),
                                fontWeight: item['type'] == type
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              )),
                        ),
                      ],
                    ),
                    onTap: () {
                      this.setState(() {
                        type = item['type'];
                      });
                      widget.getData({'type': item['type'],'page':1});
                    },
                  );
                }).toList(),
              )),
          // goods list
          Container(
            padding: EdgeInsets.all(10),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: goodsList.length,
              itemBuilder: (BuildContext context, int index) => GoodsCard(item: goodsList[index]),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              physics:const NeverScrollableScrollPhysics(), //本身不滚动，让外面的singlescrollview来滚动
              shrinkWrap: true, //收缩，让外面的singlescrollview来滚动
            ),
          )
        ],
      ),
    );
  }
}
