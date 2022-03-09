import 'package:flutter/material.dart';
import 'package:youxiake_project/utils/index.dart';

class Destination extends StatefulWidget {
  Map data = {};
  Destination({Key? key, required this.data}) : super();
  @override
  _DestinationState createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  String tabName = '';
  List choosedTab = [];
  List tabList = [];
  @override
  void initState() {
    super.initState();
    this._initData();
  }

  @override
  void didUpdateWidget(covariant Destination oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    this._initData();
  }

  void _initData() {
    if (widget.data['title'] != null) {
      tabName = widget.data['tabList'][0]['tabName'];
      choosedTab = widget.data['tabList'][0]['data'];
      tabList = widget.data['tabList'];
    }
  }

  @override
  Widget build(BuildContext context) {
    Map data = widget.data;
    if (data['title'] == null) return SizedBox();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            children: [
              // title area
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(data['title'],
                          style: TextStyle(
                              color: Util.hexColor(0x333333), fontSize: 14)),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 2),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Util.hexColor(0xfff3ea)),
                          child: Text(
                            data['subTitle'],
                            style: TextStyle(
                                color: Util.hexColor(0xff9e51), fontSize: 10),
                          )),
                    ],
                  ),
                  Text('更多>',
                      style: TextStyle(
                          color: Util.hexColor(0x333333), fontSize: 14))
                ],
              ),
              SizedBox(height: Util.sw(10)),
              // tab area
              Container(
                height: Util.sw(25),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: tabList.map<Widget>((item) {
                    return InkWell(
                      child: Container(
                        height: Util.sw(25),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 3),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Util.hexColor(0xeeeeee), width: 1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: item['tabName'] == tabName
                                ? [
                                    BoxShadow(
                                        color: Util.hexColor(0x7D7D7D,
                                            alpha: 0.15),
                                        offset: Offset(1, 1),
                                        blurRadius: 1,
                                        spreadRadius: 0)
                                  ]
                                : []),
                        child: Center(
                            child: Text(item['tabName'],
                                style: TextStyle(
                                    color: item['tabName'] == tabName
                                        ? Util.hexColor(0xe6ac00)
                                        : Util.hexColor(0x666666),
                                    fontWeight: item['tabName'] == tabName
                                        ? FontWeight.w600
                                        : FontWeight.w400))),
                      ),
                      onTap: () {
                        setState(() {
                          tabName = item['tabName'];
                          choosedTab = item['data'];
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: Util.sw(10)),
              // picture area
              Container(
                height: Util.sw(116),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GridView.count(
                    crossAxisCount: 3,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 3,
                    children: choosedTab.take(3).toList().map<Widget>((item) {
                      return Stack(
                        children: [
                          Image.network(item['image'],
                          width: Util.sw(116),
                          height: Util.sw(116),
                          fit: BoxFit.cover),Positioned(
                              bottom: Util.sw(20),
                              child: Container(
                                width: Util.sw(116),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(item['title'],style: TextStyle(color: Colors.white,fontSize:14)),
                                    Text(item['subTitle'],style:TextStyle(color: Colors.white,fontSize:12))
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // other area
              Container(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 2.4,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 6,
                  children: choosedTab.skip(3).toList().map<Widget>((item) {
                    return Stack(
                      children: [
                        Container(
                            height: Util.sw(45),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Util.hexColor(0xdddddd), width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(item['title'],
                                  style: TextStyle(
                                      color: Util.hexColor(0x333333))),
                            )),
                        item['subTitle'] != ''
                            ? Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 2, top: 1, right: 4, bottom: 1),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20)),
                                      color: Util.hexColor(0xffdd3f)),
                                  child: Text(item['subTitle'],
                                      style: TextStyle(fontSize: 10)),
                                ))
                            : SizedBox()
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          )),
    );
  }
}
