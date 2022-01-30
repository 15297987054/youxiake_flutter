import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:youxiake_project/utils/index.dart';

class TabsWidget extends StatefulWidget {
  Map data;
  TabsWidget({Key? key, required this.data}) : super(key: key);

  @override
  _TabsWidgetState createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  int type = 1;
  String _title = '';
  Map _tabData = {}; // 各tab产品
  @override
  void didUpdateWidget(covariant TabsWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.data['weekList'] != null) {
      if (_title == '') {
        setState(() {
          _title = widget.data['weekList'][0]['title'];
        });
      }
      if (_tabData['productList'] == null) {
        setState(() {
          _tabData = widget.data['weekList'][0];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Util.sw(349),
        color: Colors.white,
        child: Column(
          children: [
            Container(
                color: Colors.white,
                child: Row(
                  children: _getTabsWidget(),
                )),
            type == 1 ? _getType1() : _getType2()
          ],
        ));
  }

  // type为1
  Widget _getType1() {
    if (widget.data['weekList'] == null) return SizedBox();
    return Column(
      children: [
        // tab下的小tabs
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 34,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: Util.sw(25),
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: widget.data['weekList'].map<Widget>((item) {
                        return Row(
                          children: [
                            InkWell(
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: Util.hexColor(0xeeeeee)),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: _title == item['title']
                                          ? [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                      0.0, 1.0), //阴影xy轴偏移量
                                                  blurRadius: 1, //阴影模糊程度
                                                  spreadRadius: 0.2 //阴影扩散程度
                                                  )
                                            ]
                                          : []),
                                  child: Text(
                                    item['title'],
                                    style: TextStyle(
                                        color: _title == item['title']
                                            ? Util.hexColor(0xe6ac00)
                                            : Util.hexColor(0x333333),
                                        fontWeight: _title == item['title']
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  )),
                              onTap: () {
                                this.changeType(item);
                                setState(() {
                                  _tabData = item;
                                  _title = item['title'];
                                });
                              },
                            ),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        );
                      }).toList()),
                ),
              ),
            ],
          ),
        ),
        changeType(_tabData),
      ],
    );
  }

  // type为2
  Widget _getType2() {
    var _updata = widget.data['local'];
    if (_updata == null) return SizedBox();
    return Container(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
              child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: Util.sw(116),
                    child: Stack(
                      children: [
                        Image.network(_updata['upList'][0]['image'],
                            fit: BoxFit.fill, width: Util.sw(236)),
                        Positioned(
                          bottom: 5,
                          left: 5,
                          child: Text(_updata['upList'][0]['title'],
                              style: TextStyle(color: Colors.white)),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5)),
                                color: Util.hexColor(0x5bd07e)),
                            child: Text(_updata['upList'][0]['subTitle'],
                                style:
                                    TextStyle(fontSize: 10, color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 3),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: Util.sw(116),
                    child: Center(
                      child: Text(_updata['upList'][1]['title'],
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(_updata['upList'][1]['image']),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 10.0), //阴影xy轴偏移量
                              blurRadius: 1, //阴影模糊程度
                              spreadRadius: -16.2 //阴影扩散程度
                              )
                        ]),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              height: Util.sw(158),
              width: Util.sw(355),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _updata['downList'].asMap().entries.map<Widget>((entry) {
                      int index = entry.key;
                      Map item = entry.value;
                      return Container(
                        width: Util.sw(116),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: index==0?BorderRadius.only( bottomLeft: Radius.circular(5)):
                              index==1?BorderRadius.only( bottomRight: Radius.circular(0)):
                              BorderRadius.only( bottomRight: Radius.circular(5)),
                              child: Image.network(item['image'],
                                width: Util.sw(116),
                                height: Util.sw(116),
                                fit: BoxFit.cover),
                            ),
                            Text(
                              item['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Util.hexColor(0x333333),
                              ),
                            ),
                            Text(
                              item['subTitle'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Util.hexColor(0x999999), fontSize: 12),
                            )
                          ],
                        ),
                      );
                    }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget changeType(item) {
    var _tempList = [];
    List<Widget> _resList = [];
    for (var i = 0; i < item['productList'].length; i++) {
      _tempList.add(item['productList'][i]);
      if ((i + 1) % 6 == 0 || i == item['productList'].length - 1) {
        var _widget = Container(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1,
            physics: NeverScrollableScrollPhysics(),
            children: _tempList.map<Widget>((res) {
              return Column(
                children: [
                  Container(
                    width: Util.sw(116),
                    height: Util.sw(87),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            res['image'],
                            fit: BoxFit.fitHeight,
                            height: Util.sw(87),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                              decoration: BoxDecoration(
                                  color: Util.hexColor(0x2F2920, alpha: 0.8),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                              child: Text('￥ ${res['priceLabel']}起',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8))),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                              decoration: BoxDecoration(
                                  color: Util.hexColor(0x2F2920, alpha: 0.8),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      topRight: Radius.circular(5))),
                              child: Text(
                                  '￥ ${res['placeLabel']}起 | ${res['days']}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(res['simpleName'],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Util.hexColor(0x333333), fontSize: 14))
                ],
              );
            }).toList(),
          ),
        );
        _resList.add(_widget);
        _tempList = [];
      }
    }
    return Container(
        width: Util.sw(362),
        height: Util.sw(262),
        child: Swiper.children(
          index: 0,
          autoplay: false,
          pagination: const SwiperPagination(
              margin: EdgeInsets.zero,
              builder: DotSwiperPaginationBuilder(
                  color: Colors.black12,
                  activeColor: Colors.yellow,
                  size: 5.0,
                  activeSize: 10.0)),
          children: _resList,
        ));
  }

  // tabs组件
  List<Widget> _getTabsWidget() {
    if (widget.data['tabList'] == null) {
      return [SizedBox()];
    }
    return widget.data['tabList'].map<Widget>((item) {
      return InkWell(
        child: Container(
          height: Util.sw(44),
          decoration: BoxDecoration(
              color:
                  type == item['type'] ? Colors.white : Util.hexColor(0xeeeeee),
              borderRadius: type == item['type']
                  ? BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))
                  : BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  item['typeName'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Util.hexColor(0x333333),
                    fontSize: 14,
                  ),
                )),
            type == item['type']
                ? Container(
                    width: Util.sw(30),
                    height: Util.sw(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow),
                  )
                : SizedBox()
          ]),
        ),
        onTap: () {
          setState(() {
            type = item['type'];
          });
        },
      );
    }).toList();
  }
}
