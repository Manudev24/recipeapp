import 'package:cookingenial/models/user_model.dart';

class CommentModel {
  final String id;
  final String description;
  final int score;
  final UserModel user;
  final DateTime date;

  CommentModel({
    required this.id,
    required this.description,
    required this.score,
    required this.user,
    required this.date,
  });
}
