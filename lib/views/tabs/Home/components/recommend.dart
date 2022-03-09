import 'package:flutter/material.dart';
import 'package:youxiake_project/utils/index.dart';

class RecommendWidget extends StatefulWidget {
  Map saleProduct;
  Map newProduct;
  Map kingProduct;
  var activityBanner;
  RecommendWidget(
      {Key? key,
      required this.saleProduct,
      required this.newProduct,
      required this.kingProduct,
      required this.activityBanner})
      : super(key: key);

  @override
  _RecommendWidgetState createState() => _RecommendWidgetState();
}

class _RecommendWidgetState extends State<RecommendWidget> {
  Map salep = {};
  Map newp = {};
  Map kingp = {};
  List activityBanner = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      salep = widget.saleProduct;
      newp = widget.newProduct;
      kingp = widget.kingProduct;
      activityBanner = widget.activityBanner;
    });
  }

  @override
  void didUpdateWidget(covariant RecommendWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      salep = widget.saleProduct;
      newp = widget.newProduct;
      kingp = widget.kingProduct;
      activityBanner = widget.activityBanner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(
              Util.sw(10), Util.sw(15), Util.sw(10), Util.sw(15)),
          child: Column(
                      children: [
                        ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: Util.sw(189),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Image.network(
                              'https://m.youxiake.com/img/index_muster_bg1.9271d08c.png?t=9271d08ca5f12bdd4b11767f6c6cbe66',
                              height: Util.sw(189),
                            ),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('限时特惠',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            )),
                                        SizedBox(width: Util.sw(10)),
                                        Text('4天',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            )),
                                        SizedBox(width: Util.sw(5)),
                                        _countTime('01', showmaohao: false),
                                        _countTime('22'),
                                        _countTime('12'),
                                      ],
                                    ),
                                    Container(
                                      width: Util.sw(155),
                                      margin: EdgeInsets.only(top: Util.sw(6)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Image.network(salep['image'],
                                                    width: Util.sw(155),
                                                    height: Util.sw(79),
                                                    fit: BoxFit.cover),
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Container(
                                                    width: Util.sw(60),
                                                    height: Util.sw(20),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      10)),
                                                      gradient: LinearGradient(
                                                        begin: Alignment.topLeft,
                                                        end:
                                                            Alignment.bottomRight,
                                                        colors: [
                                                          Util.hexColor(0xfdef5b),
                                                          Util.hexColor(0xffce07),
                                                        ],
                                                      ),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            salep['stockLabel'],
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 12))),
                                                  ),
                                                ),
                                                Positioned(
                                                    bottom: 5,
                                                    left: 5,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              5, 1, 5, 2),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        color: Util.hexColor(
                                                            0x2F2920,
                                                            alpha: 0.8),
                                                      ),
                                                      child: Text(
                                                          salep['placeLabel'],
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12),
                                                          textAlign:
                                                              TextAlign.center),
                                                    ))
                                              ],
                                            ),
                                            Container(
                                                height: Util.sw(64),
                                                color: Colors.white,
                                                padding: EdgeInsets.all(5),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      salep['productName'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          TextStyle(fontSize: 12),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            '￥' +
                                                                salep[
                                                                    'priceLabel'] +
                                                                '起',
                                                            style: TextStyle(
                                                                color:
                                                                    Util.hexColor(
                                                                        0xff7100),
                                                                fontSize: 12)),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          salep[
                                                              'priceOtherLabel'],
                                                          style: TextStyle(
                                                              color:
                                                                  Util.hexColor(
                                                                      0x999999),
                                                              fontSize: 12,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                          Image.network(
                            'https://m.youxiake.com/img/index_muster_bg2.28138159.png?t=28138159131e45870defae8017a26839',
                            height: Util.sw(189),
                          ),
                          Column(
                            children: [
                              this._getRecommendWidget('新品推荐',newp),
                              Container(
                                height: 1,
                                color: Util.hexColor(0xffffff,alpha:0.5),
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0)
                                ),
                              this._getRecommendWidget('爆品路线',kingp)
                              ],
                          )
                        ]),
                      )
                    ],
                  ),
                )),
                SizedBox(height: Util.sw(10),),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisSpacing: 3,
                    crossAxisCount: activityBanner.length,
                    children: _activeWidget(),
                  )
                )
                ],
          ),
        ));
  }
  // 获取activebanner组件
  List<Widget> _activeWidget(){
    if(activityBanner[0]==null) return [SizedBox()];
    return activityBanner.map<Widget>((item){
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: new DecorationImage(
            image:new NetworkImage(item['image']),
            fit:BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['title']),
            Text(item['subTitle'],style: TextStyle(color:Util.hexColor(0x999999),fontSize:10),)
          ],
        ),
      );
    }).toList();
  }
  Widget _getRecommendWidget(String title,data) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(title, style: TextStyle(color: Colors.white)),
              SizedBox(width: 7),
              Image.network(
                  'https://m.youxiake.com/img/index_muster_arrow.2e47181a.png?t=2e47181a9192d8cb6a7fb7e9875c9fc6',
                  width: Util.sw(12),
                  height: Util.sw(12),
                  fit: BoxFit.cover),
            ],
          ),
          SizedBox(height: 4),
          Container(
                width: Util.sw(155),
                height: Util.sw(50),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    data['title'],
                    maxLines: 1,
                  ),
                  SizedBox(height: 4,),
                  Text(data['subTitle'],
                      style: TextStyle(
                          color: Util.hexColor(0xff7100), fontSize: 12)),
                ]),
              )
        ],
      ),
    );
  }

  Widget _countTime(String time, {bool showmaohao = true}) {
    return Row(children: [
      showmaohao
          ? Container(
              width: Util.sw(8),
              child: Text(':',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            )
          : SizedBox(),
      Container(
        width: Util.sw(14),
        height: Util.sw(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Util.sw(20)),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(color: Colors.red, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ]);
  }
}
