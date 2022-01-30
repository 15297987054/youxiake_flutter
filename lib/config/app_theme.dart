import 'package:flutter/material.dart';
import 'package:youxiake_project/utils/index.dart';

final ThemeData themeData = ThemeData(
  primaryColor: Util.hexColor(0xffd800),// 主题色
  scaffoldBackgroundColor: Util.hexColor(0xF5F5F5),// 页面背景色
  // splashColor: Colors.transparent,// 取消水波纹效果
  // highlightColor: Colors.transparent,// 取消水波纹效果
  indicatorColor: Colors.yellow, // 选项卡栏中所选选项卡指示器的颜色。
  // 底部按钮主题
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Util.hexColor(0x333333),
    unselectedItemColor: Util.hexColor(0x999999),
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      color: Util.hexColor(0x999999),
    ),
  ),
   // tabbar的样式
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Util.hexColor(0xffffff),
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(
      fontSize: 18,
    ),
    labelPadding: EdgeInsets.symmetric(horizontal: 12),
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Util.hexColor(0x000000),// 文字颜色
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Util.hexColor(0xffffff),
    elevation: 0,
  ),
);