import 'package:flutter/material.dart';
import 'package:youxiake_project/utils/index.dart';

class NewProductRecommendCard extends StatelessWidget {
  Map item = {};
  NewProductRecommendCard({Key? key, required this.item}) : super();
  @override
  Widget build(BuildContext context) {
    if (item['name'] == null) return SizedBox();
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(item['img'],
                      width: Util.sw(167),
                      height: Util.sw(94),
                      fit: BoxFit.cover)),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Container(
              width: Util.sw(167),
              child: Column(
                children: [
                  Text(item['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12, color: Util.hexColor(0x333333))),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '￥',
                            style: TextStyle(
                                color: Util.hexColor(0xFF7100), fontSize: 10),
                          ),
                          SizedBox(width: 2),
                          Text(
                            item['price'],
                            style: TextStyle(
                                color: Util.hexColor(0xFF7100),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '起',
                            style: TextStyle(
                                color: Util.hexColor(0x999999), fontSize: 10),
                          ),
                        ],
                      ),
                      Text(
                        item['days'],
                        style: TextStyle(
                            color: Util.hexColor(0x999999), fontSize: 10),
                      ),
                    ],
                  ),
                ],
              )),
              SizedBox(height:5)
        ],
      ),
    );
  }
}
