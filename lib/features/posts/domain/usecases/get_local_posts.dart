import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';
import 'package:practice1_app/features/posts/domain/repositories/post_repository.dart';

@lazySingleton
class GetLocalPostsUseCase {
  final PostRepository _postRepository;

  GetLocalPostsUseCase(this._postRepository);

  Future<Either<LocalFailure, List<PostEntity>>> execute() {
    return _postRepository.getLocalPosts();
  }
}
