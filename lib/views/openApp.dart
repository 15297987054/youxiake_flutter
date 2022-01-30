import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youxiake_project/utils/index.dart';

class OpenAppPage extends StatelessWidget {
  const OpenAppPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeInImage.assetNetwork(
          placeholder: 'assets/images/lazy.jpg',
          image:
              'https://m.youxiake.com/img/page_bg.8e8fb45e.jpg?t=8e8fb45efbc9d984cfc37303f39618ed',
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: Util.sw(85),
                  height: Util.sw(85),
                  fit: BoxFit.cover,
                ),
                SizedBox(height: Util.sh(33)),
                Image.network(
                  'https://m.youxiake.com/img/description.59730521.png?t=59730521125fa7b1c354627e846a49d0',
                  width: Util.sw(223),
                  height: Util.sw(50),
                  fit: BoxFit.cover,
                ),
                SizedBox(height: Util.sh(46)),
                ClipRRect(
                  child: Image.network(
                    'https://m.youxiake.com/img/open_bg.4cd38718.png?t=4cd387180a862adbb0060b91939d501a',
                    width: Util.sw(207),
                    height: Util.sw(67),
                    fit: BoxFit.cover,
                  ),
                )
              ]),
        )
      ],
    );
  }
}
