import 'dart:convert';

class ComplimentResponse {
  final bool success;
  final List<String> compliments;
  final int count;
  final String timestamp;

  ComplimentResponse({
    required this.success,
    required this.compliments,
    required this.count,
    required this.timestamp,
  });

  factory ComplimentResponse.fromJson(Map<String, dynamic> json) {
    // Handle if compliments is already a list
    List<String> complimentsList;

    if (json['compliments'] is List) {
      complimentsList = List<String>.from(json['compliments'] ?? []);
    } else if (json['compliments'] is String) {
      // If it's a string, try to parse it as JSON
      try {
        final parsed = jsonDecode(json['compliments']);
        if (parsed is List) {
          complimentsList = List<String>.from(parsed);
        } else {
          complimentsList = [json['compliments'].toString()];
        }
      } catch (e) {
        complimentsList = [json['compliments'].toString()];
      }
    } else {
      complimentsList = [];
    }

    return ComplimentResponse(
      success: json['success'] ?? false,
      compliments: complimentsList,
      count: json['count'] ?? complimentsList.length,
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'compliments': compliments,
      'count': count,
      'timestamp': timestamp,
    };
  }
}
