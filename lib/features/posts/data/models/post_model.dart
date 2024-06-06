import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@Freezed(toJson: false)
class PostModel with _$PostModel {
  const factory PostModel({
    @Default(1) int? id,
    @Default(1) int? userId,
    @Default('') String? title,
    @Default('') String? body,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, Object?> json) =>
      _$PostModelFromJson(json);

  PostEntity toEnity() => PostEntity(
        id: id!,
        userId: userId!,
        title: title!,
        body: body!,
      );
}
