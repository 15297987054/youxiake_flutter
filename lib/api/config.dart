import 'package:dio/dio.dart';

//dio方法封装
const deafultHeader = {"Accept":"application/json"};
  Future<Response?> doRequest(
    String method, 
    String url,
    data, 
    Map<String, dynamic>? queryParameters,
      Map<String, dynamic>?  header,
    {String contentType = Headers.jsonContentType,}
  ) async {
    var dio = Dio(BaseOptions(
        baseUrl: 'https://m.youxiake.com',
        connectTimeout: 5000,
        receiveTimeout: 60000,
        headers: header != null?deafultHeader:header,
        contentType: contentType,
        responseType: ResponseType.json));
    Response? response;
    try {
      switch (method) {
        case 'get':
          response = await dio.get(url, queryParameters: queryParameters);
          break;
        case 'post':
          response =
              await dio.post(url, data: data, queryParameters: queryParameters);
          break;
        case 'put':
          break;
        default:
          break;
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          print("------------连接服务器超时--------------");
          break;
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          print("------------服务器响应超时--------------");
          break;
        default:
          break;
      }
      return null;
    } on Error catch (e) {
      print("-----------请求失败---------$e");
    }
    return response;
  }

  DioFn(method, url, {data,params,header}) async {
    return await doRequest(method, url, data, params,header);
  }

