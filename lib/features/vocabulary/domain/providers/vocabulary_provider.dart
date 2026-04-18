import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/repositories/vocabulary_repository.dart';

part 'vocabulary_provider.g.dart';

@riverpod
Future<List<GreWord>> vocabulary(VocabularyRef ref) async {
  final repository = VocabularyRepository();
  return repository.loadPremiumDatabase();
}
