// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:practice1_app/core/utils/mixins/data_mapper.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';

List<PostModel> postModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel extends Equatable with DataMapper<PostModel, PostEntity> {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  PostModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  @override
  PostEntity toEntity() => PostEntity(
        id: id ?? 1,
        userId: userId ?? 1,
        title: title ?? '',
        body: body ?? '',
      );

  @override
  List<Object?> get props => [id, userId, title, body];
}
