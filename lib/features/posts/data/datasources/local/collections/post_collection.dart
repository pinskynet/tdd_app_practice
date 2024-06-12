// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
import 'package:practice1_app/core/utils/mixins/data_mapper.dart';
import 'package:practice1_app/features/posts/data/models/post_model.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';

part 'post_collection.g.dart';

@collection
class PostCollection with DataMapper<PostModel, PostEntity> {
  final Id? id;
  final int? userId;
  final String? title;
  final String? body;

  PostCollection({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  @override
  toEntity() => PostEntity(
        id: id ?? 1,
        userId: userId ?? 1,
        title: title ?? '',
        body: body ?? '',
      );

  @override
  PostModel fromEntity(PostEntity entity) => PostModel(
        id: entity.id,
        userId: entity.userId,
        title: entity.title,
        body: entity.body,
      );
}
