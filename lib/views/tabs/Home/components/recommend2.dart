import 'package:flutter/material.dart';
import 'package:youxiake_project/utils/index.dart';

class Recommend2 extends StatefulWidget {
  Map data = {};
  Recommend2({Key? key, required this.data}) : super();
  @override
  _Recommend2State createState() => _Recommend2State();
}

class _Recommend2State extends State<Recommend2> {
  @override
  Widget build(BuildContext context) {
    if (widget.data['title'] == null) return SizedBox();
    Map data = widget.data;
    List itemList = widget.data['data'];
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
          height: Util.sw(211),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    data['title'],
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                        color: Util.hexColor(0xfff3ea),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      data['subTitle'],
                      style: TextStyle(
                          color: Util.hexColor(0xff9e51), fontSize: 10),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: itemList.asMap().entries.map<Widget>((entry) {
                      int index = entry.key;
                      Map item = entry.value;
                      return Container(
                        width: Util.sw(125),
                        margin: EdgeInsets.only(right:index==itemList.length-1?Util.sw(10):Util.sw(2)),
                        decoration: BoxDecoration(
                            image: new DecorationImage(
                          image: new NetworkImage(item['image']),
                          fit: BoxFit.cover,
                        ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(index==itemList.length-1?10:0),
                            bottomRight: Radius.circular(index==itemList.length-1?10:0)
                          )
                        ),
                        child: Stack(children: [
                          Positioned(
                              bottom: Util.sw(20),
                              child: Container(
                                width:Util.sw(125),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        item['title'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                      SizedBox(height: 4),
                                      Text(item['subTitle'],
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 10))
                                    ]),
                              ))
                        ]),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
