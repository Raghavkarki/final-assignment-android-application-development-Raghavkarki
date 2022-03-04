import 'dart:convert';

import 'package:TheMerchPerch/model/get_rent.dart';
import 'package:TheMerchPerch/model/getallOrder_model.dart';
import 'package:TheMerchPerch/model/renting_model.dart';
import 'package:TheMerchPerch/utils/configs.dart';
import 'package:TheMerchPerch/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class GetAllOrders extends ChangeNotifier {
  List<AdminOrder>? _check = [];
  List<AdminOrder>? get value => _check;

  Future<dynamic> rentProduct(
    context,
  ) async {
    String? token = await SharedServices.loginDetails();
    var response = await http.get(
      Uri.parse(Configs.adminOrder),
      headers: {
        "Authorization": "Bearer $token",
        "Access-Control-Allow-Origin": "/",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      var modelProduct = adminOrderFromJson(response.body);
      _check = modelProduct;
      notifyListeners();
      return modelProduct;
    } else {
      Fluttertoast.showToast(
        msg: "Error ! \nPlease try again later.",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 20.0,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.red[800],
      );
    }
  }
}
