import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';
import 'package:practice1_app/features/posts/domain/repositories/post_repository.dart';

@lazySingleton
class GetPostsUsecase {
  final PostRepository _postRepository;

  GetPostsUsecase(this._postRepository);

  Future<Either<RemoteFailure, List<PostEntity>>> execute() {
    return _postRepository.getPosts();
  }
}
