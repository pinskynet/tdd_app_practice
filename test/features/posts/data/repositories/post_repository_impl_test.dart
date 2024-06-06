import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:practice1_app/core/error/exception.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/data/repositories/post_repository_impl.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../dummy/post_entity_fixture.dart';
import '../../dummy/post_fixture.dart';

void main() {
  late MockPostRemoteDataSource mockPostRemoteDataSource;
  late PostRepositoryImpl postRepositoryImpl;

  setUp(() {
    mockPostRemoteDataSource = MockPostRemoteDataSource();
    postRepositoryImpl = PostRepositoryImpl(mockPostRemoteDataSource);
  });

  const tPostModels = PostModelFixture.postModels;
  const tPostEntities = PostEntityFixture.postEntities;
  var serverException = ServerException('error');

  group(
    'get posts',
    () {
      test(
        'should return posts when a call to remote data source is successful',
        () async {
          // arrange
          when(
            mockPostRemoteDataSource.getPosts(),
          ).thenAnswer((realInvocation) async => tPostModels);

          // act
          final result = await postRepositoryImpl.getPosts();

          // assert
          expect(result, isA<Right<RemoteFailure, List<PostEntity>>>());
          result.fold(
            (l) => null,
            (rResult) => const Right(tPostEntities).fold(
              (l) => null,
              (rMatcher) => expect(rResult, rMatcher),
            ),
          );
        },
      );

      test(
        'should return ServerException when a call to remote data source is unsuccessful',
        () async {
          // arrange
          when(
            mockPostRemoteDataSource.getPosts(),
          ).thenThrow(serverException);

          // act
          final result = await postRepositoryImpl.getPosts();

          // assert
          expect(result, isA<Left<RemoteFailure, List<PostEntity>>>());
          expect(result, equals(Left(RemoteFailure('Unexpected error'))));
        },
      );
    },
  );
}
