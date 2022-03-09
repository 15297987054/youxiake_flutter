
import 'package:youxiake_project/api/config.dart';

class roundApi{
  /** 获取周边游页面数据 */
  static getRoundPageData(params) async {
    var data = await DioFn('get', '/api/m/channel/around',data:null,params:params );
    return data.data['data'];
  }
  /**获取周边游商品数据 */
  static getGoodsList(params) async {
    var data = await DioFn('get', '/api/m/channel/around/flow',data:null,params:params );
    return data.data['data'];
  }
}