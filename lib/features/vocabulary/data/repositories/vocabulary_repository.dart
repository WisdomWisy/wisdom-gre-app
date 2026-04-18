import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';

class VocabularyRepository {
  Future<List<GreWord>> loadPremiumDatabase() async {
    final String jsonString = await rootBundle.loadString('gre_database_premium.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    
    final List<GreWord> words = [];
    jsonMap.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        words.add(GreWord.fromJson(value));
      }
    });

    return words;
  }
}
