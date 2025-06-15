import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:phonebook_api/models/contact.dart';

class Network {
  static Uri url = Uri.parse('https://retoolapi.dev/DAa0LF/data');
  static List<Contact> contacts = [];

  static void getData() async {
    contacts.clear();
    http.get(Network.url).then((response) {
      if (response.statusCode == 200) {
        List jasonDecoded = convert.jsonDecode(response.body);
        for (var json in jasonDecoded) {
          contacts.add(Contact.fromJson(json));
        }
      }
    });
  }
}
