import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:phonebook_api/models/contact.dart';

class Network {
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
    http.get(Network.url).then((response) {
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
    await http.delete(urlWithId('2')).then((value) {
      getData();
    });
  }
}
