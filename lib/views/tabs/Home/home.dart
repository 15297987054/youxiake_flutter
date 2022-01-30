import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youxiake_project/components/ads.dart';
import 'package:youxiake_project/api/homeServer.dart';
import 'package:youxiake_project/utils/index.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:youxiake_project/views/tabs/Home/components/nav.dart';

import 'components/tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _list = {}; // 首页数据
  var _cityList = {}; // 城市数据
  List _imageList = []; // 轮播图列表
  Map _location = {
    'uid': '',
    'site_name': '',
    'sitecode': 1,
    'city_id': 1,
    'refreshCount': 80
  }; // 当前城市信息
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getData();
    this._getCityList();
  }

  // 获取首页数据
  Future<void> _getData() async {
    var list =
        await homeApi.getHomeList(new Map<String, dynamic>.from(_location));
    setState(() {
      _list = list.data['data'];
      _imageList = list.data['data']['flashImageList'];
    });
  }

  // 获取城市列表
  Future<void> _getCityList() async {
    var cityList = await homeApi.getCityList({
      'city': '',
      'lat': '',
      'lng': '',
      'siteCode': '',
    });
    var res = cityList.data['data'];
    setState(() {
      _cityList = res;
      _location = {
        ..._location,
        'sitecode': res['location']['city_id'],
        'site_name': res['location']['city_name']
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AdsWidget(),
                // 头部包含轮播部分
                Container(
                    color: Colors.white,
                    height: Util.sw(233),
                    child: Stack(
                      children: [
                        Container(
                          color: Util.hexColor(0xffdd40),
                          height: Util.sw(200),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(_location['site_name'],
                                            style:
                                                TextStyle(color: Colors.black)),
                                        Icon(Icons.arrow_drop_down_sharp)
                                      ],
                                    ),
                                    onTap: () =>
                                        _scaffoldKey.currentState?.openDrawer(),
                                  ),
                                  Container(
                                    width: Util.sw(297),
                                    height: Util.sw(29),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: Util.sw(10)),
                                        Image.network(
                                            'https://m.youxiake.com/img/index_banner_search.6acb2d36.png?t=6acb2d3607ec7636d10bbd0f217bd3fa',
                                            width: Util.sw(13),
                                            height: Util.sw(13),
                                            color: Util.hexColor(0x9999999)),
                                        SizedBox(width: Util.sw(10)),
                                        Text(
                                            _list['defaultSearch'] != null
                                                ? _list['defaultSearch']
                                                    ['title']
                                                : '',
                                            style: TextStyle(
                                                color: Util.hexColor(0x999999)))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Util.sw(10)),
                              Row(
                                children: [
                                  Text('热搜',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12)),
                                  SizedBox(width: Util.sw(10)),
                                  _getHotSearchWidget()
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            top: Util.sw(75),
                            left: Util.sw(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  width: Util.sw(355),
                                  height: Util.sw(150),
                                  child: Swiper(
                                    itemBuilder: (context, index) {
                                      return Image.network(
                                        _imageList[index] != null
                                            ? _imageList[index]['image']
                                            : '/assets/images/lazy.jpg',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    autoplay: true,
                                    itemCount: _imageList.length,
                                    scrollDirection: Axis.horizontal,
                                    pagination: SwiperPagination(
                                        margin: EdgeInsets.zero,
                                        builder: SwiperCustomPagination(
                                            builder: (context, config) {
                                          return ConstrainedBox(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child:
                                                    const DotSwiperPaginationBuilder(
                                                            color:
                                                                Colors.black12,
                                                            activeColor:
                                                                Colors.yellow,
                                                            size: 5.0,
                                                            activeSize: 10.0)
                                                        .build(context, config),
                                              ),
                                              constraints:
                                                  const BoxConstraints.expand(
                                                      height: 25.0));
                                        })),
                                  )),
                            ))
                      ],
                    )),
                // 轮播图下nav
                NavWidget(),
                MidNavWidget(),
                SizedBox(height:10),
                // tab切换组件
                TabsWidget(data: _list['aroundLump']!=null?_list['aroundLump']:{}),
              ],
            ),
          ),
        ),
        drawer: _drawer(_cityList));
  }

  // 热搜组件
  Widget _getHotSearchWidget() {
    var arr = _list['hotSearchList'] != null ? _list['hotSearchList'] : [];
    if (arr.length == 0) return SizedBox();
    var tempList = arr.map<Widget>((item) {
      return Container(
        width: Util.sw(74),
        height: Util.sw(20),
        margin: EdgeInsets.only(right: Util.sw(10)),
        decoration: BoxDecoration(
            color: Util.hexColor(0xffffff80, alpha: 0.3),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          item['title'],
          textAlign: TextAlign.center,
        ),
      );
    }).toList();
    return Expanded(
        child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: arr.length,
            childAspectRatio: 3.7,
            children: tempList));
  }

  // 抽屉组件
  Widget _drawer(_cityList) {
    return Drawer(
        child: new SafeArea(
            child: Padding(
      padding: EdgeInsets.fromLTRB(Util.sw(15), 0, Util.sw(15), Util.sw(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部
          Container(
              height: Util.sh(44),
              color: Util.hexColor(0xf7f7f7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: Util.sw(100)),
                  Text('选择城市', style: TextStyle(color: Colors.black))
                ],
              )),
          _getSubtitle('定位/附近城市'),
          _getListItem(_location),
          _getSubtitle('一级站点'),
          _getWidgetList(_cityList['sites']),
          _getSubtitle('二级站点'),
          _getWidgetList(_cityList['secondsites']),
          _getSubtitle('热门旅游城市'),
          _getWidgetList(_cityList['citys']),
        ],
      ),
    )));
  }

  // 抽屉列表组件
  Widget _getWidgetList(locationMsg) {
    if (locationMsg == null) return SizedBox();
    var widgetList = locationMsg.map<Widget>((item) {
      return _getListItem(item);
    }).toList();
    return Expanded(
        // 二级站点
        child: GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 10.0,
      crossAxisCount: 3,
      // padding: EdgeInsets.all(10),
      mainAxisSpacing: 10,
      childAspectRatio: 2.7,
      children: widgetList,
    ));
  }

  Widget _getListItem(item) {
    if (item == null) return SizedBox();
    return InkWell(
      child: Container(
          width: Util.sw(88),
          height: Util.sw(32),
          decoration: BoxDecoration(
            color: item['sitecode'] != null &&
                    item['sitecode'] == _location['sitecode']
                ? Util.hexColor(0xfff7d1)
                : Util.hexColor(0xf4f4f4),
            border: item['sitecode'] != null &&
                    item['sitecode'] == _location['sitecode']
                ? Border.all(color: Util.hexColor(0xfed61a), width: 1)
                : null,
            borderRadius: BorderRadius.circular(ScreenUtil().radius(18)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item['site_name'] != null
                  ? Icon(Icons.person_pin_circle, size: Util.sw(15))
                  : SizedBox(),
              Text(item[item['site_name'] != null ? 'site_name' : 'name'],
                  textAlign: TextAlign.center)
            ],
          )),
      onTap: () {
        setState(() {
          _location = {
            ...item,
            'site_name': item['name'],
            'city_id': item['sitecode']
          };
        });
        _getData();
        Navigator.pop(context);
      },
    );
  }

  Widget _getSubtitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Text(title,
          style: TextStyle(
              color: Util.hexColor(0x888888),
              textBaseline: TextBaseline.ideographic)),
    );
  }
}
