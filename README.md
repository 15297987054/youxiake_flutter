# youxiake_project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## flutter_screenUtil5.1.0 用法
## ScreenUtil().setWidth(540)  (dart sdk>=2.6 : 540.w) //Adapted to screen width
## ScreenUtil().setHeight(200) (dart sdk>=2.6 : 200.h) //Adapted to screen height , under normal circumstances, the height still uses x.w
## ScreenUtil().radius(200)    (dart sdk>=2.6 : 200.r)    //Adapt according to the smaller of width or height
## ScreenUtil().setSp(24)      (dart sdk>=2.6 : 24.sp) //Adapter font
## 12.sm   //return min(12,12.sp)
## 
## ScreenUtil().pixelRatio       //Device pixel density
## ScreenUtil().screenWidth   (dart sdk>=2.6 : 1.sw)    //Device width
## ScreenUtil().screenHeight  (dart sdk>=2.6 : 1.sh)    //Device height
## ScreenUtil().bottomBarHeight  //Bottom safe zone distance, suitable for buttons with full screen
## ScreenUtil().statusBarHeight  //Status bar height , Notch will be higher
## ScreenUtil().textScaleFactor  //System font scaling factor
## 
## ScreenUtil().scaleWidth //The ratio of actual width to UI design
## ScreenUtil().scaleHeight //The ratio of actual height to UI design
## 
## ScreenUtil().orientation  //Screen orientation
