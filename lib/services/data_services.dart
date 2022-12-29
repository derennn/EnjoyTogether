import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agalarla_mac/basic_classes/event_class.dart';

class DataService {
  final String baseUrl = 'https://638a2a0dc5356b25a2142b60.mockapi.io/';

  Future<Event> getEvent(int input) async {
    final response = await http.get(Uri.parse('$baseUrl/events/$input'));

    if (response.statusCode == 200) {
      return Event.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Event indirilemedi ${response.statusCode}');
    }
  }

  Future<void> addEvent(Event event) async {
    final response = await http.post(
      Uri.parse('$baseUrl/events'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:  jsonEncode(event.toMap()),
    );

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Bir şeyler test gitti. Lütfen daha sonra tekrar deneyin. Hata kodu: ${response.statusCode}');
    }
  }

  Future<List<Event>> getAllEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events'));
    if (response.statusCode == 200) {
      final l = jsonDecode(utf8.decode(response.bodyBytes));
      return l.map<Event>((e) {
        return Event.fromMap(e);
      }).toList();
    } else {
      throw Exception('Eventler alınamadı ${response.statusCode}');
    }
  }
}

final dataServiceProvider = Provider((ref) {
  return DataService();
});