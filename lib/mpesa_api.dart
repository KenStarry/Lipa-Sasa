import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class MPesaApi {
  final dio = Dio();

  //  username
  final consumerKey = 'W4jkFURnhPyqDI5tsrXHkFUZTmTEwkZqxSeWtMMEKCeDuulO';

  //  password
  final consumerSecret =
      'BGvJHCWF465pGfxpgku53B6wUhxjactVOJqX4InsrmbMLmq6Gu6c95wwi63pAu1k';

  String getCurrentTimestamp() {
    final currentDate = DateTime.now();

    return DateFormat('yyyyMMddHHmmss').format(currentDate);
  }

  //  Getting the Access Token
  Future<String> getAccessToken() async {
    //  getting header value for Authorization
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}';

    final dio = Dio();

    //  getting credentials to get access Token
    final credentials = await dio.get(
        'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials',
        options: Options(headers: {'authorization': basicAuth}));

    final credentialsJson =
        jsonDecode(credentials.toString()) as Map<String, dynamic>;

    return credentialsJson['access_token'];
  }

  Future<void> sendSTKPush() async {
    final accessToken = await getAccessToken();

    //  getting header value for Authorization
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}';

    const passKey =
        'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919';

    final timeStamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());

    final encodedPassword =
        base64Encode(utf8.encode('174379$passKey$timeStamp'));

    final response = await dio.post(
        'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest',
        data: {
          //  Buy Goods / Paybill Number
          "BusinessShortCode": 174379,
          "Password": encodedPassword,
          "Timestamp": timeStamp,
          // CustomerPayBillOnline for paybill or CustomerBuyGoodsOnline for buy goods
          "TransactionType": "CustomerPayBillOnline",
          "Amount": 1,
          "PartyA": 254717446607,
          //  Buy Goods / Paybill Number
          "PartyB": 174379,
          "PhoneNumber": 254717446607,
          "CallBackURL":
              "https://us-central1-mpesa-integration-tutorial.cloudfunctions.net/api/myCallbackUrl",
          "AccountReference": "Starry Codes",
          "TransactionDesc": "Payment of some sweet cheeks"
        },
        options: Options(headers: {
          'Key': 'Authorization',
          //  Daraja username and password token
          'Value': basicAuth,
          //  Access token gotten from above
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    print("-------RESPONSE : ${response.statusMessage}");
  }
}
