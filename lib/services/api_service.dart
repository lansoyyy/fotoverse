import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  getBibleVerses(String keyword) async {
    const apiBaseUrl = "https://api.esv.org/v3/passage/search/";
    const apiKey =
        "Token ef504304dcdfb29c9f7d0949910ec0e8d4185978"; // Replace with your ESV API key

    final url = Uri.parse('$apiBaseUrl?q=$keyword');
    final response = await http.get(url, headers: {
      "Authorization": "Token $apiKey",
    });

    return json.decode(response.body);

    // if (response.statusCode == 200) {
    //   final jsonData = json.decode(response.body);
    //   final passages = jsonData['passages'];

    //   if (passages.isNotEmpty) {
    //     for (var passage in passages) {
    //       print(passage);
    //     }
    //   } else {
    //     print("No Bible verses found for the provided keyword.");
    //   }
    // } else {
    //   print(
    //       "Failed to fetch Bible verses. Status code: ${response.statusCode}");
    // }
  }
}
