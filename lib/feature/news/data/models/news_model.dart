import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  final int id;
  final String name;
  final String email;
  final bool isActive;

  NewsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
