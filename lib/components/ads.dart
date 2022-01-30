import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youxiake_project/views/openApp.dart';
import 'package:youxiake_project/utils/index.dart';

class AdsWidget extends StatefulWidget {
  @override
  _AdsWidgetState createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  bool _showAds = true;
  @override
  Widget build(BuildContext context) {
    if (_showAds) {
      return Stack(
        children: [
          Image.network(
            'https://m.youxiake.com/img/index_download_bg.7930e421.png?t=7930e4217dd08f4e111ed76183ba73fe',
            width: MediaQuery.of(context).size.width,
            height: Util.sh(75),
            fit: BoxFit.cover,
          ),
          Container(
            height: Util.sh(75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Image.network(
                      'https://m.youxiake.com/img/index_download_close.f5091a7d.png?t=f5091a7d00a5878808cb9b0aa5bf6564',
                      width: Util.sw(13),
                      height: Util.sh(13),
                      fit: BoxFit.cover),
                  onTap: () {
                    print('建立啊');
                    setState(() {
                      _showAds = false;
                    });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset('assets/images/logo.png',
                    width: 45, height: 45, fit: BoxFit.cover),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '游侠客-让旅行充满想象',
                      style: _getTextStyle(15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('户外、摄影、亲子、深度人文', style: _getTextStyle(13))
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('打开APP', style: _getTextStyle(15))),
                    onTap: () {
                      Navigator.pushNamed(context, '/openPage');
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  _getTextStyle(int fontSize) {
    return TextStyle(
        color: Colors.white, fontSize: ScreenUtil().setSp(fontSize));
  }
}
