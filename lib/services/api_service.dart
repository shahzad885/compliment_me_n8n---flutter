import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/compliment_response.dart';

class ApiService {
  static const String _baseUrl = 'your n8n webhook URL';

  static Future<String> _imageToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }

  /// Send image to n8n and get compliments
  static Future<ComplimentResponse> getCompliments(File imageFile) async {
    try {
      print('🔵 Starting API call to: $_baseUrl');

      // Convert image to base64
      final base64Image = await _imageToBase64(imageFile);
      print('🔵 Image converted to base64, length: ${base64Image.length}');

      // Prepare request body
      final body = jsonEncode({
        'image': base64Image,
      });

      print('🔵 Sending POST request...');

      // Make POST request
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('🔵 Response status: ${response.statusCode}');
      print('🔵 Response body: ${response.body}');
      print('🔵 Response type: ${response.body.runtimeType}');

      // Check response status
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('🔵 Decoded JSON: $jsonResponse');
        print('🔵 JSON type: ${jsonResponse.runtimeType}');

        // If response is a Map, parse normally
        if (jsonResponse is Map<String, dynamic>) {
          return ComplimentResponse.fromJson(jsonResponse);
        }
        // If response is a List (array of compliments directly)
        else if (jsonResponse is List) {
          return ComplimentResponse(
            success: true,
            compliments: List<String>.from(jsonResponse),
            count: jsonResponse.length,
            timestamp: DateTime.now().toIso8601String(),
          );
        } else {
          throw Exception(
              'Unexpected response format: ${jsonResponse.runtimeType}');
        }
      } else if (response.statusCode == 404) {
        throw Exception(
          'Webhook not found. Make sure your n8n workflow is Active and the URL is correct.\n\nURL: $_baseUrl\n\nStatus: ${response.statusCode}',
        );
      } else {
        throw Exception(
          'Failed to get compliments.\nStatus: ${response.statusCode}\nResponse: ${response.body}',
        );
      }
    } catch (e) {
      print('🔴 Error: $e');
      rethrow;
    }
  }
}
