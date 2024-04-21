import 'dart:convert';
import 'package:dio/dio.dart';

class MPesaApi {
  final dio = Dio();

  Future<String> getAccessToken() async {
    //  username
    const consumerKey = 'W4jkFURnhPyqDI5tsrXHkFUZTmTEwkZqxSeWtMMEKCeDuulO';
    //  password
    const consumerSecret =
        'BGvJHCWF465pGfxpgku53B6wUhxjactVOJqX4InsrmbMLmq6Gu6c95wwi63pAu1k';

    //  getting header value for Authorization
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}';

    //  getting credentials to get access Token
    final credentials = await dio.get(
        'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials',
        options: Options(headers: {'authorization': basicAuth}));

    final credentialsJson = jsonDecode(credentials.toString()) as Map<String, dynamic>;

    return credentialsJson['access_token'];
  }
}
