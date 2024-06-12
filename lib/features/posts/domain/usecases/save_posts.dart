import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';
import 'package:practice1_app/features/posts/domain/repositories/post_repository.dart';

@lazySingleton
class SavePostsUseCase {
  final PostRepository _postRepository;

  SavePostsUseCase(this._postRepository);

  Future<Either<LocalFailure, bool>> savePosts(
      {required List<PostEntity> posts}) {
    return _postRepository.savePosts(posts);
  }
}
