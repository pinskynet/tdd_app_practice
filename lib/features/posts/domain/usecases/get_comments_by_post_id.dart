import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/domain/entities/comment_entity.dart';
import 'package:practice1_app/features/posts/domain/repositories/post_repository.dart';

@LazySingleton()
class GetCommentsByPostIdUseCase {
  final PostRepository _postRepository;

  GetCommentsByPostIdUseCase(this._postRepository);

  Future<Either<RemoteFailure, List<CommentEntity>>> execute({required int postId}) {
    return _postRepository.getCommentsByPostId(postId);
  }
}
