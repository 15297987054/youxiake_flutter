
// 获取首页数据

import 'package:youxiake_project/api/config.dart';

class searchApi{
  /** 获取搜索页数据 */
  static getList(params) {
    return DioFn('get', '/api/m/search/hot',data:null,params:params );
  }
}