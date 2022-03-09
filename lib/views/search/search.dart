import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youxiake_project/api/searchServer.dart';
import 'package:youxiake_project/components/newProductRecommendCard.dart';
import 'package:youxiake_project/utils/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youxiake_project/views/loading.dart';

class SearchPage extends StatefulWidget {
  final arguments;
  SearchPage({this.arguments}) : super();

  @override
  _SearchPageState createState() => _SearchPageState(arguments: this.arguments);
}

class _SearchPageState extends State<SearchPage> {
  final arguments;
  _SearchPageState({this.arguments});
  Map _data = {};
  List _goodsList = [];
  int _totalSize = 0;
  int pagenum = 1;
  List hotSerach = [];
  List recommendSearch = [];
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    // _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use loadNodata()
    if (mounted) setState(() {});
    _getData(++this.pagenum);
    // _refreshController.loadComplete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData(pagenum);
  }

  // 获取数据
  Future<void> _getData(page) async {
    if(_goodsList.length>0&&_totalSize==_goodsList.length) {
      _refreshController.loadNoData();
      return;
    };
    try{
      var data = await searchApi.getList({"page": page});
      _data = data.data['data'];
    setState(() {
      if(hotSerach.length==0) hotSerach=_data['hotSerach'];
      if(recommendSearch.length==0) recommendSearch=_data['recommendSearch'];
      _totalSize = _data['total'];
      _goodsList..addAll(_data['productNewRecommends']);
      // _goodsList = [
      //   ..._goodsList,
      //   ..._data['productNewRecommends']
      // ];
    });
    _refreshController.loadComplete();
    }catch(e){
      print(e);
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hotSerach.isEmpty) return const Loading();
    return Scaffold(
      body:  SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败！点击重试！");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("松手,加载更多!");
            } else {
              body = Text("没有更多数据了!");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            // search area
            Container(
              color: Util.hexColor(0xf4f4f4),
              padding: EdgeInsets.only(
                  left: Util.sw(15),
                  right: Util.sw(15),
                  top: Util.sw(10),
                  bottom: Util.sw(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: Util.sw(30),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: arguments != null
                                ? arguments['placeholder']
                                : '',
                            hintStyle:
                                TextStyle(color: Util.hexColor(0x999999)),
                            alignLabelWithHint: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            prefixIcon: ImageIcon(
                              NetworkImage(
                                  'https://m.youxiake.com/img/img42.a52c3f2d.png?t=a52c3f2d0064dd3945020ae574a8f33d',
                                  scale: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Util.hexColor(0xdddddd), width: 1),
                                borderRadius: BorderRadius.circular(50))),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Text('取消',
                        style: TextStyle(
                            color: Util.hexColor(0x333333), fontSize: 14)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            // recommend area
            Container(
              padding: EdgeInsets.only(top: Util.sw(10), left: Util.sw(10)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(width: 1, color: Util.hexColor(0xdddddd)),
                      bottom: BorderSide(
                          width: 1, color: Util.hexColor(0xeeeeee)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text('搜索推荐',
                          style: TextStyle(
                              color: Util.hexColor(0x999999), fontSize: 14))),
                  SizedBox(height: 10),
                  _scrollImageList(recommendSearch),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Util.sw(10), left: Util.sw(10)),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text('搜索排行',
                          style: TextStyle(
                              color: Util.hexColor(0x999999), fontSize: 14))),
                  SizedBox(height: 10),
                  _scrollTextList(hotSerach),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Util.hexColor(0xeeeeee)),
                  bottom: BorderSide(width: 1, color: Util.hexColor(0xeeeeee)),
                ),
                color: Colors.white,
              ),
              child: Container(
                height: Util.sw(46),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('没有你想要的？',
                        style: TextStyle(
                            color: Util.hexColor(0x999999), fontSize: 12)),
                    Container(
                        width: Util.sw(150),
                        padding: EdgeInsets.only(
                            left: Util.sw(30),
                            top: Util.sw(5),
                            right: Util.sw(30),
                            bottom: Util.sw(5)),
                        decoration: BoxDecoration(
                          color: Util.hexColor(0xfffae5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text('目的地大全 >',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Util.hexColor(0x333333), fontSize: 12)))
                  ],
                ),
              ),
            ),
            // new product recommend
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding:
                          EdgeInsets.only(top: Util.sw(10), left: Util.sw(10)),
                      child: Text('新品推荐',
                          style: TextStyle(
                              color: Util.hexColor(0x999999), fontSize: 14))),
                  SizedBox(height: 10),
                  _scrollGoodsList(_goodsList, context),
                ],
              ),
            ),
          ],
        )),
      ),
      )
    );
  }

  // 顶部搜索推荐
  Widget _scrollImageList(List data) {
    return Container(
      height: Util.sw(125),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: data.map<Widget>((item) {
          return Container(
            width: Util.sw(117),
            margin: EdgeInsets.only(right: Util.sw(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(item['cover'],
                      width: Util.sw(117),
                      height: Util.sw(67),
                      fit: BoxFit.cover),
                ),
                Text(
                  item['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Text(item['subTitle'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Util.hexColor(0x999999),
                    ))
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // 搜索排行
  Widget _scrollTextList(List data) {
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 6,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: Util.sw(2),
        children: data.asMap().entries.map<Widget>((entry) {
          int index = entry.key;
          Map item = entry.value;
          return Container(
            height: Util.sw(20),
            child: Row(children: [
              index < 3
                  ? Container(
                      child: Text((index + 1).toString()),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://m.youxiake.com/img/img46.9e67aee8.png?t=9e67aee811c8dc55842ed94ea55b009a',
                                  scale: 2))),
                    )
                  : SizedBox(),
              index >= 3 ? Text((index + 1).toString()) : SizedBox(),
              SizedBox(width: 5),
              Text(
                item['title'],
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 6,
              ),
              index < 3
                  ? Image.network(
                      'https://m.youxiake.com/img/img45.5235ed09.png?t=5235ed09ce1b5493bdd3c95f34952c67',
                      width: Util.sw(12),
                      height: Util.sw(12))
                  : SizedBox()
            ]),
          );
        }).toList(),
      ),
    );
  }

  // 新品推荐
  Widget _scrollGoodsList(List data, BuildContext context) {
    return Container(
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          childAspectRatio: 1.15,
          physics: NeverScrollableScrollPhysics(),
          children: data.map<Widget>((item) {
            return NewProductRecommendCard(item: item);
          }).toList(),
        ),
    );
  }
}
