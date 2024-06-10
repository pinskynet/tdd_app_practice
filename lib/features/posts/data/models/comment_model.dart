// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

import 'package:practice1_app/core/utils/mixins/data_mapper.dart';
import 'package:practice1_app/features/posts/domain/entities/comment_entity.dart';

List<CommentModel> commentModelFromJson(String str) => List<CommentModel>.from(
    json.decode(str).map((x) => CommentModel.fromJson(x)));

String commentModelToJson(List<CommentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentModel with DataMapper<CommentModel, CommentEntity> {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  CommentModel({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };

  @override
  CommentEntity toEntity() => CommentEntity(
        postId: postId ?? 1,
        id: id ?? 1,
        name: name ?? '',
        email: email ?? '',
        body: body ?? '',
      );
}
