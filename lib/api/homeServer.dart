
// 获取首页数据

import 'package:youxiake_project/api/config.dart';

class homeApi{
  /** 获取首页数据 */
  static getHomeList(params) {
    return DioFn('get', '/api/m/index/part',data:null,params:params );
  }
  /**获取地区列表 */
  static getCityList(params){
    return DioFn('get','/api/m/index/city',data:null,params:params);
  }
}