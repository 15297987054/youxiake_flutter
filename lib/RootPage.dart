import 'package:flutter/material.dart';
import 'package:youxiake_project/views/tabs/Home/home.dart';
import 'package:youxiake_project/views/tabs/my.dart';
import 'package:youxiake_project/views/tabs/order.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}
final List<Widget> _pages =[
  HomePage(),
  OrderPage(),
  MyPage(),
];
int _currentIndex = 0;
class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('游侠客',style: TextStyle(color: Colors.red) ),
      // ),
      body:_pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.network('https://m.youxiake.com/img/img1.4ac4c20c.png?t=4ac4c20c4fe8d2e0b6f616a5c118edee',
            width:21,height: 20),
            activeIcon: Image.network('https://m.youxiake.com/img/img11.9384aa4a.png?t=9384aa4ae9296d247405216cee79487e',
            width:27,height: 27
            ),
            label: '首页'
          ),
           BottomNavigationBarItem(
            icon: Image.network('https://m.youxiake.com/img/img2.12aa5813.png?t=12aa5813aaa709101e9b8de880bf9896',
            width:21,height: 20),
            activeIcon: Image.network('https://m.youxiake.com/img/img22.98e00f94.png?t=98e00f940ebc2543cff229d902daf3ac',
            width:27,height: 27),
            label: '订单'
          ),
           BottomNavigationBarItem(
            icon: Image.network('https://m.youxiake.com/img/img3.8fd2bd15.png?t=8fd2bd15867c66a0cf04ac0b0bd36ceb',
            width:21,height: 20),
            activeIcon: Image.network('https://m.youxiake.com/img/img33.3d66679c.png?t=3d66679c7f45ec8577d253f4fb7ecdc7',
            width:27,height: 27),
            label: '个人中心'
          ),
        ],
      ),
    );
  }
}