import 'dart:convert' as convert;
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phonebook_api/models/contact.dart';

class Network {
  static bool isConnected = false;
  static Future<bool> checkInternet() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        isConnected = false;
      } else {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          isConnected = true;
        } else {
          isConnected = false;
        }
      }
    } catch (e) {
      print('Internet check error: $e');
      isConnected = false;
    }
    print('Network connection status: $isConnected');
    return isConnected;
  }

  static void showInternetError(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'خطا',
      desc: 'شما به اینترنت متصل نیستید!',
      btnOkOnPress: () {},
    ).show();
  }

  static Uri url = Uri.parse('https://retoolapi.dev/DAa0LF/data');
  static Uri urlWithId(String id) {
    Uri url = Uri.parse(
      'https://retoolapi'
      '.dev/DAa0LF/data/$id',
    );
    return url;
  }

  static List<Contact> contacts = [];

  static Future<void> getData() async {
    contacts.clear();
    await http.get(Network.url).then((response) {
      if (response.statusCode == 200) {
        List jasonDecoded = convert.jsonDecode(response.body);
        for (var json in jasonDecoded) {
          contacts.add(Contact.fromJson(json));
        }
      }
    });
  }

  static Future<void> postData({
    required String phone,
    required String fullname,
  }) async {
    Contact contact = Contact(phone: phone, fullname: fullname);
    await http.post(Network.url, body: contact.toJson()).then((response) {
      print(response.body);
    });
  }

  static Future<void> putData({
    required String phone,
    required String fullname,
    required String id,
  }) async {
    Contact contact = Contact(phone: phone, fullname: fullname);
    await http.put(urlWithId(id), body: contact.toJson()).then((response) {
      print(response.body);
    });
  }

  static Future<void> deleteContact(String id) async {
    await http.delete(urlWithId(id)).then((value) {
      getData();
    });
  }
}
