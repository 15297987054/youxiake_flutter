import 'package:flutter/material.dart';
import 'package:youxiake_project/utils/index.dart';

class NavWidget extends StatelessWidget {
  List _navList = [
    {
      'label': '周边游',
      'url':
          'https://m.youxiake.com/img/index_nav_around.6afbabd8.png?t=6afbabd80e7745a078ef8321ae51cb76'
    },
    {
      'label': '国内游',
      'url':
          'https://m.youxiake.com/img/index_nav_cn.b39dc0d0.png?t=b39dc0d0ba6559ede004b9c43000db36'
    },
    {
      'label': '出境游',
      'url':
          'https://m.youxiake.com/img/index_nav_en.213dedbc.png?t=213dedbce91a1bb2a5e96b71c685f1f7'
    },
    {
      'label': '自由行',
      'url':
          'https://m.youxiake.com/img/index_nav_free.b8cb8c43.png?t=b8cb8c436beb846fa4ccea7e8ad0f2ed'
    },
    {
      'label': '酒店民宿',
      'url':
          'https://m.youxiake.com/img/index_nav_hotel.19e12527.png?t=19e12527d9dd8a71c7588744daf07549'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: Util.sw(68),
        color: Colors.white,
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: 1,
            crossAxisCount: _navList.length,
            children: _getNavWidget(context),
          ),
        );
  }

  List<Widget> _getNavWidget(BuildContext context) {
    return _navList.map((item) {
      return InkWell(
              child: Column(
          children: [
            Image.network(item['url'], width: Util.sw(44), height: Util.sw(44)),
            Text(item['label'],
                style: TextStyle(color: Util.hexColor(0x333333), fontSize: 12)),
          ],
        ),
        onTap: (){
          Navigator.pushNamed(context, '/round',arguments: {
            'title':item['label']
          });
        },
      );
    }).toList();
  }
}

class MidNavWidget extends StatelessWidget {
  List _navList = [
    {
      'label': '亲子游',
      'url':
          'https://m.youxiake.com/img/index_nav_02.a65092c6.png?t=a65092c6438b701a5259d546f039c89b'
    },
    {
      'label': '摄影游',
      'url':
          'https://m.youxiake.com/img/index_nav_03.92ef4c76.png?t=92ef4c761e0e5208e5369bd5b34926ab'
    },
    {
      'label': '户外游',
      'url':
          'https://m.youxiake.com/img/index_nav_04.c8b118c8.png?t=c8b118c858f88ca932bb81fffc8b6e81'
    },
    {
      'label': '活动赛事',
      'url':
          'https://m.youxiake.com/img/index_nav_05.e886ceea.png?t=e886ceeafe6f8290e6799a6a0550fd50'
    },
    {
      'label': '瑜伽行',
      'url':
          'https://m.youxiake.com/img/index_nav_06.7425efc7.png?t=7425efc719e6797852dbc63198d803f2'
    },
    {
      'label': '野奢邦',
      'url':
          'https://m.youxiake.com/img/index_nav_07.cbf0ecbf.png?t=cbf0ecbf5080641fd7f828bf4505d60a'
    },
  ];
  List _navList1 = [
    {
      'label': '定制游',
      'url':
          'https://m.youxiake.com/img/index_nav_08.8633db5b.png?t=8633db5bd5be4df5bf677b9e44216b90'
    },
    {
      'label': '签证',
      'url':
          'https://m.youxiake.com/img/index_nav_09.9da340d6.png?t=9da340d679af466edd4f2ad171461aca'
    },
    {
      'label': '邮轮',
      'url':
          'https://m.youxiake.com/img/index_nav_10.2f5c92d2.png?t=2f5c92d2122c7b4f7900d3206287fa0e'
    },
    {
      'label': '美宿度假',
      'url':
          'https://m.youxiake.com/img/index_nav_11.39fc0b20.png?t=39fc0b203615391db7c7bb9eae5e9bd4'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: Util.sw(86),
              child: Row(
                children: [
                  _commonItem({
                    'label': '主题游',
                    'url':
                        'https://m.youxiake.com/img/index_nav_01.82fac2d4.png?t=82fac2d4e1f151f5d9ebf7939b891e28'
                  }, 89, 89, show: true),
                  Expanded(
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      childAspectRatio: 2.05,
                      children: _getNavWidget(),
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: Util.sw(45),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    childAspectRatio: 2.2,
                    children: _getNav1Widget(),
                  ),
                )
          ],
        ));
  }

  List<Widget> _getNavWidget() {
    return _navList.map((item) {
      return _commonItem(item, 86, 45);
    }).toList();
  }

  List<Widget> _getNav1Widget() {
    return _navList1.map((item) {
      return _commonItem(item, 89, 45);
    }).toList();
  }

  Widget _commonItem(Map item, int width, int height, {show}) {
    return Container(
        width: Util.sw(width),
        height: Util.sw(height),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(item['url']),
          fit: BoxFit.fill,
        )),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item['label'],
                style: TextStyle(color: Util.hexColor(0x333333), fontSize: 14)),
            SizedBox(height: 3),
            show != null
                ? Container(
                    decoration: BoxDecoration(
                        color: Util.hexColor(0xffd800),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('个性独创', style: TextStyle(fontSize: 10)),
                  )
                : SizedBox()
          ],
        )));
  }
}
