import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:findlaptop/models/models.dart';
import 'package:findlaptop/utils/utils.dart';

class NetworkServices {
  static final String url = 'https://findlaptop-backend-service.herokuapp.com';

  static BaseOptions options = BaseOptions(
    baseUrl: '$url/api',
    // connectTimeout: 5000,
    // receiveTimeout: 5000,
    contentType: Headers.formUrlEncodedContentType,
    responseType: ResponseType.json,
  );

  static Dio dio = Dio(options);

  static Map<String, dynamic> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future getByProducts({
    String? product,
    String? type,
    String? cpu,
    String? company,
    String? ram,
    String? opsys,
    int low = 0,
    int high = 100000000000000000,
    String? inches,
    int? limit,
  }) async {
    Map<String, dynamic>? queryParameter = {
      'product': product,
      'low': low,
      'high': high,
      'inches': inches == null ? null : double.parse(inches),
      'type': type,
      'cpu': cpu,
      'company': company,
      'ram': ram,
      'operating_system': opsys,
      'limit': limit ?? 25,
    };

    logger.v(queryParameter);

    try {
      Response res = await dio.post(
        '/product',
        queryParameters: queryParameter,
        options: Options(headers: header),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 &&
          res.data['status'] < 300 &&
          res.data['success'] == true) {
        return (res.data['data'] as List)
            .map((val) => Laptop.fromJson(val))
            .toList();
      }
      return res.data['message'];
    } on DioError catch (e) {
      logger.e(e);
      if (e.response != null) {
        return e.response?.data['message'];
      } else {
        return 'Kesalahan Jaringan';
      }
    } catch (e) {
      logger.e(e);
      return 'Kesalahan Jaringan';
    }
  }

  static Future getBrand() async {
    try {
      Response res = await dio.get(
        '/company',
        options: Options(headers: header),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 &&
          res.data['status'] < 300 &&
          res.data['success'] == true) {
        return (res.data['data'] as List)
            .map((val) => val['company'].toString())
            .toList();
      }
      return res.data['message'];
    } on DioError catch (e) {
      logger.e(e);
      if (e.response != null) {
        return e.response?.data['message'];
      } else {
        return 'Kesalahan Jaringan';
      }
    } catch (e) {
      logger.e(e);
      return 'Kesalahan Jaringan';
    }
  }

  static Future getInches() async {
    try {
      Response res = await dio.get(
        '/inches',
        options: Options(headers: header),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 &&
          res.data['status'] < 300 &&
          res.data['success'] == true) {
        return (res.data['data'] as List)
            .map((val) => val['inches'].toString())
            .toList();
      }
      return res.data['message'];
    } on DioError catch (e) {
      logger.e(e);
      if (e.response != null) {
        return e.response?.data['message'];
      } else {
        return 'Kesalahan Jaringan';
      }
    } catch (e) {
      logger.e(e);
      return 'Kesalahan Jaringan';
    }
  }

  static Future getType() async {
    try {
      Response res = await dio.get(
        '/type',
        options: Options(headers: header),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 &&
          res.data['status'] < 300 &&
          res.data['success'] == true) {
        return (res.data['data'] as List)
            .map((val) => val['typeName'].toString())
            .toList();
      }
      return res.data['message'];
    } on DioError catch (e) {
      logger.e(e);
      if (e.response != null) {
        return e.response?.data['message'];
      } else {
        return 'Kesalahan Jaringan';
      }
    } catch (e) {
      logger.e(e);
      return 'Kesalahan Jaringan';
    }
  }

  static Future getRam() async {
    try {
      Response res = await dio.get(
        '/ram',
        options: Options(headers: header),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 &&
          res.data['status'] < 300 &&
          res.data['success'] == true) {
        return (res.data['data'] as List)
            .map((val) => val['ram'].toString())
            .toList();
      }
      return res.data['message'];
    } on DioError catch (e) {
      logger.e(e);
      if (e.response != null) {
        return e.response?.data['message'];
      } else {
        return 'Kesalahan Jaringan';
      }
    } catch (e) {
      logger.e(e);
      return 'Kesalahan Jaringan';
    }
  }
}
