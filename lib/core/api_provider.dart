///DIO
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../data/remote/remote_routes/app_remote_routes.dart';
import '../presentation/routes/LocalStorageNames.dart';
import 'custom_exception.dart';
import 'pretty_printer.dart';

class ApiProvider {
  late Dio _dio;

  ApiProvider() {
    _dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
        followRedirects: false,
        headers: {
          "access-control-allow-origin": "*",
          // "Access-Control-Allow-Origin": "*",
          // "Access-Control-Allow-Credentials": false,
          'Content-Type': 'application/json'
        },
        baseUrl: AppRemoteRoutes.baseUrl,
        connectTimeout: const Duration(minutes: 5),
        receiveTimeout: const Duration(minutes: 5),
      ),
    );
    if (!kIsWeb) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  addToken() {
    final getstorage = GetStorage();
    String? accesstoken = getstorage.read(LocalStorageNames.accessTokenKEY);
    String? refreshtoken = getstorage.read(LocalStorageNames.refreshTokenKEY);
    if (accesstoken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accesstoken);
      prettyPrint(decodedToken["name"]);
      bool isTokenExpired = JwtDecoder.isExpired(accesstoken);
      Duration tokenTime = JwtDecoder.getTokenTime(accesstoken);
      prettyPrint("token time =${tokenTime.inMinutes}");
      if (!isTokenExpired) {
        _dio.options.headers.addAll({'authorization': 'Bearer $accesstoken'});
      } else {
        _dio.options.headers.addAll({'Cookie': 'refreshToken=$refreshtoken'});
      }
      _dio.options.headers.addAll(
          {'accessToken': '$accesstoken', 'refreshToken': "$refreshtoken"});
    } else {
      prettyPrint("Access token is null");
    }
  }

  Future<dynamic> get(String endPoint) async {
    try {
      addToken();
      prettyPrint(_dio.options.headers.toString());
      final Response response = await _dio.get(
        endPoint,
      );
      prettyPrint("request url : ${response.realUri}");
      final responseData = classifyResponse(response);

      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.toString(), type: PrettyPrinterTypes.error);
      throw BadRequestException();
    }
  }

  Future<dynamic> delete(String endPoint) async {
    try {
      addToken();
      prettyPrint(_dio.options.headers.toString());
      final Response response = await _dio.delete(
        endPoint,
      );
      prettyPrint("getting response ${response.realUri}");
      final responseData = classifyResponse(response);
      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.toString(), type: PrettyPrinterTypes.error);
      return {};
    }
  }

  ///Method 1
  Future<dynamic> post(
    String endPoint,
    dynamic body,
  ) async {
    prettyPrint("on post call$body");
    try {
      prettyPrint("starting dio");

      addToken();
      // prettyPrint(_dio.options.)
      final Response response = await _dio.post(
        endPoint,
        data: body,
      );

      prettyPrint("getting response${response.realUri}");
      final responseData = classifyResponse(response);
      prettyPrint(responseData.toString());
      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.toString());
      throw FetchDataException("internetError");
    }
  }

  ///Method 2
  // Future<dynamic> post(
  //   String endPoint,
  //   dynamic body,
  // ) async {
  //   prettyPrint("on post call $body");
  //   try {
  //     prettyPrint("starting dio");

  //     addToken();
  //     // prettyPrint(_dio.options.)
  //     final Response response = await _dio.post(
  //       endPoint,
  //       data: body,
  //     );

  //     prettyPrint("getting response ${response.realUri}");
  //     final responseData = classifyResponse(response);
  //     prettyPrint(responseData.toString());
  //     return responseData;
  //   } on DioException catch (err) {
  //     // prettyPrint(err.toString());
  //     // throw FetchDataException("internetError");
  //     prettyPrint("DioError: ${err.message}");
  //     if (err.type == DioExceptionType.connectionTimeout) {
  //       throw FetchDataException("Connection Timeout Exception");
  //     } else if (err.type == DioExceptionType.sendTimeout) {
  //       throw FetchDataException("Send Timeout Exception");
  //     } else if (err.type == DioExceptionType.receiveTimeout) {
  //       throw FetchDataException("Receive Timeout Exception");
  //     } else if (err.type == DioExceptionType.badResponse) {
  //       prettyPrint("Response data: ${err.response?.data}");
  //       prettyPrint("Response headers: ${err.response?.headers}");
  //       throw FetchDataException(
  //           "Received invalid status code: ${err.response?.statusCode}");
  //     } else if (err.type == DioExceptionType.cancel) {
  //       throw FetchDataException("Request Cancelled");
  //     } else if (err.type == DioExceptionType.unknown) {
  //       throw FetchDataException("Network Error: ${err.message}");
  //     }
  //   } catch (e) {
  //     prettyPrint("Unexpected Error: $e");
  //     throw FetchDataException("$e");
  //   }
  // }

  ///Method 3
  // Future<dynamic> post(
  //   String endPoint,
  //   dynamic body,
  // ) async {
  //   prettyPrint("on post call $body");
  //   try {
  //     prettyPrint("starting dio");

  //     final Response response = await _dio.post(
  //       endPoint,
  //       data: body,
  //     );
  //     prettyPrint("getting response ${response.realUri}");
  //     final responseData = classifyResponse(response);
  //     prettyPrint(responseData.toString());
  //     return responseData;
  //   } on DioException catch (err) {
  //     prettyPrint("DioError caught: ${err.message}");
  //     if (err.response != null) {
  //       prettyPrint("Response data: ${err.response?.data}");
  //       prettyPrint("Response headers: ${err.response?.headers}");
  //       prettyPrint("Response status code: ${err.response?.statusCode}");
  //     } else {
  //       prettyPrint("Error type: ${err.type}");
  //       // prettyPrint("Error message: ${err.message}");
  //     }
  //     throw FetchDataException("Network Error: ${err.message}");
  //   } catch (e) {
  //     prettyPrint("API Provider Unexpected Error: $e");
  //     prettyPrint(e.toString());
  //     throw FetchDataException("Unexpected Error: $e");
  //   }
  // }

  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    prettyPrint("on post call");
    try {
      addToken();
      final Response response = await _dio.put(
        endPoint,
        data: body,
      );

      final responseData = classifyResponse(response);

      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.message, type: PrettyPrinterTypes.error);
      throw FetchDataException("internetError");
    }
  }

  Future<dynamic> request(
      String endPoint, Map<String, dynamic> body, String method) async {
    prettyPrint("on request call");
    try {
      addToken();
      final Response response = await _dio.request(
        endPoint,
        options: Options(method: method, headers: {
          "access-control-allow-origin": "*",
          "Accept": "*/*",
          // "Authorization": "Bearer accesstoken",
          "Content-Type": "multipart/form-data"
        }),
        data: body,
      );

      final responseData = classifyResponse(response);
      return responseData;
    } on DioException catch (err) {
      // prettyPrint(err.message, type: PrettyPrinterTypes.error);
      // throw FetchDataException("internetError");
      if (err.type == DioExceptionType.connectionTimeout ||
          err.type == DioExceptionType.sendTimeout ||
          err.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException("Connection timeout");
      } else if (err.type == DioExceptionType.connectionError) {
        throw FetchDataException("No internet connection");
      } else if (err.response != null) {
        // Handle different status codes
        switch (err.response!.statusCode) {
          case 400:
            throw BadRequestException(err.response!.data.toString());
          case 401:
          case 403:
            throw UnauthorizedException(err.response!.data.toString());
          case 404:
            throw NotFoundException(err.response!.data.toString());
          case 500:
          default:
            throw ServerException(err.response!.data.toString());
        }
      } else {
        throw FetchDataException(
            "An error occurred while communicating with server");
      }
    } catch (e) {
      prettyPrint(e.toString(), type: PrettyPrinterTypes.error);
      throw FetchDataException("An unexpected error occurred");
    }
  }

  // Future<Uint8List> download({required String imageUrl}) async {
  //   final tempStorage = await getTemporaryDirectory();
  //   final data = await _dio.download(imageUrl, tempStorage.path);
  //   final d = data.data;
  // }

  // var error = responseData["errors"];
  //     if (error != null && error is List) {
  //       var allErrors = error
  //           .map((item) => item["message"] ?? "")
  //           .where((msg) => msg.isNotEmpty);
  //       errorMsg = allErrors.join(", ");
  //     }

  // Map<String, dynamic> classifyResponse(Response response) {
  dynamic classifyResponse(Response response) {
    if (kDebugMode) {
      print(response);
    }
    // try {
    // final responseData =
    final responseData =
        // response.data as Map<String, dynamic>;
        response.data;
    String errorMsg = "";
    try {
      // errorMsg=responseData["error"][""]
      // var error = responseData["errors"];
      // var allErrors = error!.map((item) => item["message"]);
      // String errorString = "";
      // for (var i in allErrors) {
      //   errorString = "$errorString$i,";
      // }
      var error = responseData["errors"];
      if (error != null && error is List) {
        var allErrors = error
            .map((item) => item["message"] ?? "")
            .where((msg) => msg.isNotEmpty);
        errorMsg = allErrors.join(", ");
      }
    } catch (e) {
      errorMsg = responseData.toString();
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData;
      case 400:
        throw BadRequestException(errorMsg);
      case 404:
        throw BadRequestException(errorMsg);
      case 401:
        throw UnauthorizedException(errorMsg);
      case 403:
        throw UnauthorizedException(errorMsg);
      case 409:
        throw DeleteConflictException(errorMsg);
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
    // } catch (e) {
    //   throw BadRequestException("something went  wrong");
    // }
  }
}

///HTTP
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiProvider {
//   final String _baseUrl;
//
//   ApiProvider(this._baseUrl);
//
//   Future<Map<String, dynamic>> get(String endpoint) async {
//     final response = await http.get(Uri.parse('$_baseUrl$endpoint'));
//     return _processResponse(response);
//   }
//
//   Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('$_baseUrl$endpoint'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(data),
//     );
//     return _processResponse(response);
//   }
//
//   Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
//     final response = await http.put(
//       Uri.parse('$_baseUrl$endpoint'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(data),
//     );
//     return _processResponse(response);
//   }
//
//   Future<Map<String, dynamic>> delete(String endpoint) async {
//     final response = await http.delete(Uri.parse('$_baseUrl$endpoint'));
//     return _processResponse(response);
//   }
//
//   Map<String, dynamic> _processResponse(http.Response response) {
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       return jsonDecode(response.body) as Map<String, dynamic>;
//     } else {
//       throw http.ClientException(
//         'Failed to load data: ${response.statusCode} ${response.reasonPhrase}',
//         Uri.parse(response.request!.url.toString()),
//       );
//     }
//   }
// }
