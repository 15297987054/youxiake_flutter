import 'package:flutter/material.dart';
import 'package:youxiake_project/utils/index.dart';

class GoodsCard extends StatelessWidget {
  var item = null;
  GoodsCard({Key? key, required this.item}) : super();
  @override
  Widget build(BuildContext context) {
    if (item['dataDetail'] == null) return SizedBox();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: _getCard(item),
    );
  }

  // 获取商品卡片
  Widget _getCard(Map item) {
    switch (item['type']) {
      case 3:
        return _getThreeType(item['dataDetail']);
      case 4:
        return _imageWidget(item['dataDetail']);
      case 7:
        return _travelWidget(item['dataDetail']);
      case 5:
        return _readWidget(item['dataDetail']);
      case 6:
        return _planWidget(item['dataDetail']);
      case 9:
      return _videoCardWidget(item['dataDetail']);
      case 10:
      return _huwaiWidget(item['dataDetail']);
    }
    return _getNormalWidget(item['dataDetail']);
  }

  // 通用 type=1
  Widget _getNormalWidget(Map data) {
    return Container(
      width: Util.sw(172),
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(data['image'],
                  width: Util.sw(172), height: Util.sw(130), fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(Util.sw(10))),
                  color: Util.hexColor(0x000000, alpha: 0.5),
                ),
                padding: EdgeInsets.only(left: 4, top: 1, right: 4, bottom: 1),
                child: Text(data['placeLabel'],
                    style: TextStyle(color: Colors.white, fontSize: 10)),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                data['title'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Util.hexColor(0x333333), fontSize: 14),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                data['productType'] +
                    '·' +
                    data['productCat'] +
                    '·' +
                    data['days'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Util.hexColor(0x999999), fontSize: 12),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        double.tryParse(data['priceLabel']) != null?Text('￥',
                            style: TextStyle(
                                color: Util.hexColor(0xff7100), fontSize: 10)):SizedBox(),
                        Text(
                          data['priceLabel'],
                          style: TextStyle(
                              color: Util.hexColor(0xff7100),
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        double.tryParse(data['priceLabel']) != null?Text('起',
                            style: TextStyle(
                                color: Util.hexColor(0xff7100), fontSize: 10)):SizedBox(),
                      ],
                    ),
                  ),
                  Text(
                    data['numLabel'],
                    style:
                        TextStyle(color: Util.hexColor(0x999999), fontSize: 10),
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }

  // type = 3
  Widget _getThreeType(Map data) {
    return Container(
      width: Util.sw(172),
      color: Colors.white,
      child: Column(
        children: [
          Image.network(data['image'],
              width: Util.sw(172), height: Util.sw(172), fit: BoxFit.cover),
          Stack(
            children: [
              Image.network(
                  'https://m.youxiake.com/img/zt.5ca275cd.png?t=5ca275cdaac92385dae0f4a9796a9ca9',
                  width: Util.sw(172),
                  height: Util.sw(82),
                  fit: BoxFit.cover),
              Container(
                width:Util.sw(172),
                margin: EdgeInsets.only(top:Util.sw(10)),
                  child: Text(data['title'],
                  textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.white))),
              Container(
                 width:Util.sw(172),
                 margin: EdgeInsets.only(top:Util.sw(50)),
                  child: Text(data['subTitle'],
                  textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: Colors.white)))
            ],
          )
        ],
      ),
    );
  }

  //  图片 type=4
  Widget _imageWidget(Map data) {
    return Image.network(data['image'],
        width: Util.sw(172), height: Util.sw(229), fit: BoxFit.cover);
  }
  // 户外 type=10
  Widget _huwaiWidget(Map data){
    return Container(
      child: Stack(
        children: [
          Image.network(data['image'],width:Util.sw(172),height: Util.sw(262),fit:BoxFit.cover),
          Positioned(
            bottom:Util.sw(20),
child:Container(
            width:Util.sw(172),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:Util.sw(81),
                  height:Util.sw(27),
                  padding: EdgeInsets.only(left:Util.sw(14)),
                  decoration: BoxDecoration(
                    image:DecorationImage(image: NetworkImage(data['typeImage']))
                  ),
                  child: Center(
                    child:Text(data['title'],style:TextStyle(color: Colors.white,fontSize: 10)),
                  ),
                ),
                SizedBox(height: Util.sw(20),),
                Text(data['subTitle'],style:TextStyle(color:Util.hexColor(0x333333),fontSize: 12)),
              ],
            )
          )
          ),
          
        ],
      )
    );
  }
  //  去旅行 type=7
  Widget _travelWidget(Map data) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.network(data['image'],
                  width: Util.sw(172), height: Util.sw(172), fit: BoxFit.cover),
              Positioned(
                  bottom: Util.sw(-10),
                  right: Util.sw(15),
                  child: Image.network(
                      'https://m.youxiake.com/img/travel_icon.fa630116.png?t=fa63011634adcdad18995143d0dcf3cc',
                      width: Util.sw(57),
                      height: Util.sw(21),
                      fit: BoxFit.cover))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.only(left: Util.sw(10)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['title'],
                        style: TextStyle(
                          color: Util.hexColor(0x333333),
                          fontSize: 14,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data['numLabel'],
                      style: TextStyle(
                          color: Util.hexColor(0x333333), fontSize: 10),
                    ),
                    SizedBox(height: 10),
                  ]))
        ],
      ),
    );
  }

  // 浏览 type = 5
  Widget _readWidget(Map data) {
    return Container(
      width: Util.sw(172),
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.network(data['image'],
                  width: Util.sw(172), height: Util.sw(172), fit: BoxFit.cover),
              Positioned(
                bottom: Util.sw(-12),
                left: Util.sw(10),
                child: Image.network(
                    'https://m.youxiake.com/img/travel.d1dd2034.png?t=d1dd20340d7a52f6bc25d3de2d82f17f',
                    width: Util.sw(75),
                    height: Util.sw(22),
                    fit: BoxFit.cover),
              )
            ],
          ),
          Container(
              padding: EdgeInsets.all(Util.sw(10)),
              child: Column(
                children: [
                  Text(data['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Util.hexColor(0x333333), fontSize: 12)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Util.sw(22),
                            height: Util.sw(22),
                            child: CircleAvatar(
                                backgroundImage: NetworkImage(data['avatar'])),
                          ),
                          SizedBox(width: 4),
                          Text(data['username'],
                              style: TextStyle(
                                  color: Util.hexColor(0x999999),
                                  fontSize: 10)),
                        ],
                      ),
                      Text(data['numLabel'],
                          style: TextStyle(
                              color: Util.hexColor(0x999999), fontSize: 10))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }

  // 攻略 type=6
  Widget _planWidget(Map data) {
    return Container(
      width: Util.sw(172),
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Image.network(data['image'],
                  width: Util.sw(172), height: Util.sw(172), fit: BoxFit.cover),
              Positioned(
                  bottom: Util.sw(-9),
                  left: Util.sw(10),
                  child: Container(
                      padding:
                          EdgeInsets.only(left: 4, top: 1, right: 4, bottom: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Util.hexColor(0xfed101),
                      ),
                      child: Text(
                        '攻略',
                        style: TextStyle(
                            color: Util.hexColor(0x333333), fontSize: 12),
                      )))
            ],
          ),
          Container(
              padding: EdgeInsets.all(Util.sw(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Util.hexColor(0x333333), fontSize: 12)),
                  SizedBox(height: 10),
                  Text(
                    data['numLabel'],
                    style:
                        TextStyle(color: Util.hexColor(0x999999), fontSize: 12),
                  ),
                ],
              ))
        ],
      ),
    );
  }
  // 视频card
  Widget _videoCardWidget(Map data){
    return Container(
      width: Util.sw(172),
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Image.network(data['image'],
                  width: Util.sw(172), height: Util.sw(172), fit: BoxFit.cover),
              Positioned(
                  bottom: Util.sw(9),
                  left: Util.sw(10),
                  child: Container(
                      padding:
                          EdgeInsets.only(left: 4, top: 1, right: 4, bottom: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Util.hexColor(0x000000,alpha: 0.4),
                      ),
                      child: Text(
                        data['address'],
                        style: TextStyle(
                            color: Colors.white, fontSize: 12),
                      ))),
            ],
          ),
          Container(
              padding: EdgeInsets.all(Util.sw(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Util.hexColor(0x333333), fontSize: 12)),
                  SizedBox(height: 5),
                  Container(
                    height:Util.sw(20),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: data['tagList'].map<Widget>((item){
                        return Container(
                          padding:EdgeInsets.only(left:3,top:1,bottom:1,right:3),
                          decoration: BoxDecoration(
                            color: Util.hexColor(0x999999,alpha:0.3),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child:Text(item,style:TextStyle(color:Util.hexColor(0xff7100),fontSize: 12))),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(data['numLabel'],style:TextStyle(color:Util.hexColor(0x999999),fontSize: 10))
                ],
              ))
        ],
      ),
    );
  }
}
