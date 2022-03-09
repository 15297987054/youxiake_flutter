import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youxiake_project/api/round-travel-server.dart';
import 'package:youxiake_project/components/goodsCard.dart';
import 'package:youxiake_project/utils/index.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../loading.dart';

class RoundPage extends StatefulWidget {
  final arguments;
  RoundPage({this.arguments}) : super();

  @override
  _RoundPageState createState() => _RoundPageState();
}

class _RoundPageState extends State<RoundPage> {
  List _flashList = [];
  Map _flowTag = {};
  Map _plate = {};
  Map _popularPlay = {};
  List _firstTypeList = [];
  List _secondTypeList = [];
  List _goodsList = [];
  int _firstType = 608;
  int _secondType = 0;
  int _pagenum = 0;
  int _totalPage = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGoodsList();
    _getPageData();
  }

  Future<void> _getPageData() async {
    var data = await roundApi.getRoundPageData({'sitecode': 1, 'city_id': 1});
    setState(() {
      _flashList = data['flashList'];
      _flowTag = data['flowTag'];
      _plate = data['plate'];
      _popularPlay = data['popularPlay'];
    });
  }

  Future<void> _getGoodsList({int firstType = 608, int secondType = 0}) async {
    if (_goodsList.length > 0 && _pagenum >= _totalPage) {
      _refreshController.loadNoData();
      return;
    }
    try {
      var data = await roundApi.getGoodsList({
        'sitecode': 1,
        'city_id': 1,
        'firstType': firstType,
        'secondType': secondType,
        'page': _pagenum,
        'spm': '',
      });
      setState(() {
        if (_firstTypeList.isEmpty) {
          _firstTypeList =
              data['flowTag'] != null ? data['flowTag']['firstTypeList'] : [];
          _secondTypeList =
              data['flowTag'] != null ? data['flowTag']['secondTypeList'] : [];
        }
        _totalPage = data['data']['totalPage'];
        if (_pagenum > 0) {
          _goodsList = _goodsList..addAll(data['data']['list']);
        } else {
          _goodsList = data['data']['list'];
        }
        _firstType = firstType;
        _secondType = secondType;
      });
      if (_pagenum == 0) {
        _refreshController.refreshCompleted();
      }
      if (_pagenum > 0) {
        _refreshController.loadComplete();
      }
    } catch (e) {
      print(e);
      _refreshController.loadFailed();
    }
  }

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {
      _pagenum = 0;
    });
    _getGoodsList();
    // _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use loadNodata()
    if (mounted) setState(() {});
    setState(() {
      _pagenum = ++_pagenum;
    });
    _getGoodsList();
    // _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    if (_flashList.isEmpty) return const Loading();
    Map props = widget.arguments;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: Util.sw(268),
                child: Stack(
                  children: [
                    Image.network(
                        'https://m.youxiake.com/img/bg.9c1ef3ad.png?t=9c1ef3ad7264c9d53dddc55ac9570723',
                        width: Util.sw(375),
                        height: Util.sw(210),
                        fit: BoxFit.fill),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          Util.sw(10), Util.sw(15), Util.sw(10), Util.sw(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Icon(Icons.arrow_back,
                                color: Colors.white, size: Util.sw(24)),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(props['title'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          Icon(Icons.person,
                              color: Colors.white, size: Util.sw(24)),
                        ],
                      ),
                    ),
                    Container(
                      width: Util.sw(355),
                      height: Util.sw(30),
                      margin:
                          EdgeInsets.only(top: Util.sw(55), left: Util.sw(10)),
                      decoration: BoxDecoration(
                        color: Util.hexColor(0xffffff, alpha: 0.25),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Util.hexColor(0x000000, alpha: 0.1),
                              blurRadius: 1)
                        ],
                      ),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Icon(Icons.search,
                                  color: Colors.white, size: 15),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(width: Util.sw(10)),
                            Text('搜索目的地/关键词',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/search',
                              arguments: {'placeholder': props['title']});
                        },
                      ),
                    ),
                    Container(
                        width: Util.sw(355),
                        height: Util.sw(150),
                        margin: EdgeInsets.fromLTRB(
                            Util.sw(10), Util.sw(105), Util.sw(10), 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Swiper(
                            itemBuilder: (context, index) {
                              return Image.network(
                                _flashList[index] != null
                                    ? _flashList[index]['image']
                                    : '/assets/images/lazy.jpg',
                                fit: BoxFit.cover,
                              );
                            },
                            autoplay: true,
                            itemCount: _flashList.length,
                            scrollDirection: Axis.horizontal,
                            pagination: SwiperPagination(
                                margin: EdgeInsets.zero,
                                builder: SwiperCustomPagination(
                                    builder: (context, config) {
                                  return ConstrainedBox(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: const DotSwiperPaginationBuilder(
                                                color: Colors.black12,
                                                activeColor: Colors.yellow,
                                                size: 5.0,
                                                activeSize: 10.0)
                                            .build(context, config),
                                      ),
                                      constraints: const BoxConstraints.expand(
                                          height: 25.0));
                                })),
                          ),
                        )),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _popularPlay['title'],
                          style: TextStyle(
                              color: Util.hexColor(0x333333), fontSize: 20),
                        ),
                        Row(
                          children: [
                            Text('查看榜单',
                                style: TextStyle(
                                    color: Util.hexColor(0x9e9e9e),
                                    fontSize: 12)),
                            Image.network(
                                'https://m.youxiake.com/img/rightArrow.ff5dfaac.png?t=ff5dfaac35102645bf38cb994dc84fe8',
                                width: Util.sw(6),
                                height: Util.sw(10),
                                fit: BoxFit.cover)
                          ],
                        )
                      ],
                    ),
                  ),
                  // 人气尖货
                  Container(
                    height: Util.sw(185),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: _popularPlay['productList']
                          .asMap()
                          .entries
                          .map<Widget>((entry) {
                        int index = entry.key;
                        Map item = entry.value;
                        return _recommendCard(index, item,
                            total: _popularPlay['productList'].length);
                      }).toList(),
                    ),
                  ),
                ],
              ),
              // 中部图片
              Container(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: _imgRecommendCard(_plate['plateFirst'])),
                          SizedBox(width: 5),
                          Expanded(
                            flex: 1,
                            child: _imgRecommendCard(_plate['plateList'][0]),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisSpacing: 5,
                          crossAxisCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          children:
                              _plate['plateList'].skip(1).map<Widget>((item) {
                            return _imgRecommendCard(item,
                                height: 115, top: 55);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 商品列表
              StickyHeader(
                overlapHeaders: true,
                header: Container(
                    height: Util.sw(96),
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _firstTypeList.map<Widget>((item) {
                              return InkWell(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Stack(
                                    children: [
                                      item['type'] == _firstType
                                          ? Positioned(
                                              top: 7,
                                              left: 0,
                                              right: 0,
                                              child: Image.network(
                                                  'https://m.youxiake.com/img/nav_bg.1845d123.png',
                                                  width: Util.sw(48),
                                                  height: Util.sw(35),
                                                  fit: BoxFit.fill),
                                            )
                                          : SizedBox(),
                                      Center(
                                        child: Text(
                                          item['title'],
                                          style: TextStyle(
                                              fontSize:
                                                  item['type'] == _firstType
                                                      ? 18
                                                      : 14,
                                              fontWeight:
                                                  item['type'] == _firstType
                                                      ? FontWeight.w500
                                                      : FontWeight.w400,
                                              color: item['type'] == _firstType
                                                  ? Util.hexColor(0x333333)
                                                  : Util.hexColor(0x555555)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _firstType = item['type'];
                                  });
                                  _getGoodsList(
                                      firstType: item['type'],
                                      secondType: _secondType);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          height: Util.sw(54),
                          padding:
                              EdgeInsets.only(left: 10, top: 14, bottom: 14),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _secondTypeList.map<Widget>((item) {
                              return InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.only(
                                      top: 2, bottom: 2, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: _secondType == item['type']
                                          ? Util.hexColor(0xffd410)
                                          : Util.hexColor(0x999999)),
                                  child: Center(
                                    child: Text(
                                      item['title'],
                                      style: TextStyle(
                                          fontSize: item['type'] == _secondType
                                              ? 14
                                              : 12,
                                          fontWeight:
                                              item['type'] == _secondType
                                                  ? FontWeight.w500
                                                  : FontWeight.w400,
                                          color: item['type'] == _secondType
                                              ? Util.hexColor(0x333333)
                                              : Util.hexColor(0x555555)),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _secondType = item['type'];
                                  });
                                  _getGoodsList(
                                      firstType: _firstType,
                                      secondType: item['type']);
                                },
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    )),
                content: Container(
                  padding: EdgeInsets.only(top: Util.sw(96)),
                  
                  child: Container(
                        padding: const EdgeInsets.all(10),
                        // height: MediaQuery.of(context).size.height-30,
                        child:
                      //   SmartRefresher(
                      // enablePullDown: true,
                      // enablePullUp: true,
                      // header: WaterDropHeader(),
                      // footer: CustomFooter(
                      //   builder: (BuildContext context, LoadStatus? mode) {
                      //     Widget body;
                      //     if (mode == LoadStatus.idle) {
                      //       body = Text("上拉加载");
                      //     } else if (mode == LoadStatus.loading) {
                      //       body = CupertinoActivityIndicator();
                      //     } else if (mode == LoadStatus.failed) {
                      //       body = Text("加载失败！点击重试！");
                      //     } else if (mode == LoadStatus.canLoading) {
                      //       body = Text("松手,加载更多!");
                      //     } else {
                      //       body = Text("没有更多数据了!");
                      //     }
                      //     return Container(
                      //       height: 55.0,
                      //       child: Center(child: body),
                      //     );
                      //   },
                      // ),
                      // controller: _refreshController,
                      // onRefresh: _onRefresh,
                      // onLoading: _onLoading,
                      // child: 
                       MasonryGridView.count(
                          crossAxisCount: 2,
                          itemCount: _goodsList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              GoodsCard(item: _goodsList[index]),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          physics:
                              const NeverScrollableScrollPhysics(), //本身不滚动，让外面的singlescrollview来滚动
                          shrinkWrap: true, //收缩，让外面的singlescrollview来滚动
                        ),
                      )
                      ),
                )
              // )
            ],
          ),
        ),
      )),
    );
  }

  // 活动推荐item
  Widget _imgRecommendCard(Map data, {height = 136, top = 75}) {
    return Stack(
      children: [
        Image.network(data['image'],
            width: Util.sw(235), height: Util.sw(height), fit: BoxFit.cover),
        data['day'] != null
            ? Positioned(
                top: Util.sw(10),
                left: Util.sw(10),
                child: Text(data['day'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500)))
            : SizedBox(),
        data['month'] != null
            ? Positioned(
                top: Util.sw(40),
                left: Util.sw(10),
                child: Text(data['month'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500)))
            : SizedBox(),
        Positioned(
          top: Util.sw(top),
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
            decoration: BoxDecoration(
                color: Util.hexColor(0x000000, alpha: 0.65),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(10))),
            child: Center(
              child: Text(data['title'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
        Positioned(
            top: Util.sw(top + 30),
            left: Util.sw(10),
            child: Text(data['subTitle'],
                style: TextStyle(fontSize: 12, color: Colors.white)))
      ],
    );
  }

  // 人气尖货item
  Widget _recommendCard(int index, Map item, {total}) {
    return Container(
      height: Util.sw(165),
      // width:Util.sw(160),
      margin: EdgeInsets.only(
          left: Util.sw(10),
          right: total - 1 == index ? Util.sw(10) : 0,
          top: Util.sw(10)),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Util.hexColor(0x777777, alpha: 0.12),
              blurRadius: 4,
              spreadRadius: 1),
        ],
        borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
        // border: Border.all(color:Colors.black,width:1),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            width: Util.sw(150),
            // height: Util.sw(100),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(10)),
                  child: Image.network(item['image'],
                      width: Util.sw(150),
                      height: Util.sw(100),
                      fit: BoxFit.cover),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Image.network(
                        index == 0
                            ? 'https://m.youxiake.com/img/1.87085b16.png?t=87085b16bbad2f58242c020c4e007c46'
                            : index == 1
                                ? 'https://m.youxiake.com/img/2.45836fa8.png?t=45836fa87b4aef719e287b1c75b9e0c3'
                                : index == 2
                                    ? 'https://m.youxiake.com/img/3.bdf4cc10.png?t=bdf4cc10e3d939ce3146f22b9d91e2d5'
                                    : 'https://m.youxiake.com/img/4.9f6bdec4.png?t=9f6bdec4976b02f71e1f78105e14a6c3',
                        width: Util.sw(27),
                        height: Util.sw(27),
                        fit: BoxFit.cover)),
                index == 0
                    ? Positioned(
                        top: -5,
                        left: -5,
                        child: Image.network(
                            'https://m.youxiake.com/img/top1.e93b8882.png?t=e93b8882216a4e2c308da031355fba79',
                            width: Util.sw(18),
                            height: Util.sw(19),
                            fit: BoxFit.cover))
                    : SizedBox(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    padding:
                        EdgeInsets.only(left: Util.sw(10), right: Util.sw(10)),
                    height: Util.sw(15),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Util.hexColor(0xff795a),
                            Util.hexColor(0xfe3c22)
                          ],
                        ),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10))),
                    child: Row(
                      children: [
                        Image.network(
                            'https://m.youxiake.com/img/fire.ced59379.png?t=ced593795d6d8e00794ec8687117ad7e',
                            width: Util.sw(15),
                            height: Util.sw(18),
                            fit: BoxFit.cover),
                        Text(
                          item['numLabel'],
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: Util.sw(10),
                top: Util.sw(5),
                right: Util.sw(10),
                bottom: Util.sw(5)),
            width: Util.sw(150),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item['productCat'] + '·' + item['placeLabel'],
                  style:
                      TextStyle(color: Util.hexColor(0x9e9e9e), fontSize: 12)),
              Text(item['title'],
                  style:
                      TextStyle(color: Util.hexColor(0x333333), fontSize: 14)),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('￥' + item['priceLabel'],
                          style: TextStyle(
                              color: Util.hexColor(0xff7100), fontSize: 14)),
                      Text('起',
                          style: TextStyle(
                              color: Util.hexColor(0x9e9e9e), fontSize: 10)),
                    ],
                  ),
                  Text(item['days'],
                      style: TextStyle(
                          color: Util.hexColor(0x555555), fontSize: 12))
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}
