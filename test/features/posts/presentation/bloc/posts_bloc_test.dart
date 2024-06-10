import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:practice1_app/core/error/exception.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/presentation/bloc/posts_bloc.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../dummy/post_entity_fixture.dart';

// class MockPostsBloc extends MockBloc<PostsEvent, PostsState>
//     implements PostsBloc {}

// late MockWeatherBloc mockWeatherBloc;

void main() {
  const tPostEntities = PostEntityFixture.postEntities;

  group(
    'Posts bloc test',
    () {
      final mockGetPostsUsecase = MockGetPostsUsecase();
      final mockGetCommentsByPostIdUsecase = MockGetCommentsByPostIdUseCase();

      blocTest<PostsBloc, PostsState>(
        'should emit [PostsLoading -> PostsLoadSuccess] when success',
        build: () {
          when(
            mockGetPostsUsecase.execute(),
          ).thenAnswer((realInvocation) async => const Right(tPostEntities));

          return PostsBloc(mockGetPostsUsecase, mockGetCommentsByPostIdUsecase);
        },
        act: (bloc) => bloc.add(GetPosts()),
        expect: () => [
          PostsLoading(),
          const PostsLoadSuccess(posts: tPostEntities),
        ],
        verify: (_) => verify(mockGetPostsUsecase.execute()).called(1),
      );

      blocTest<PostsBloc, PostsState>(
        'should emit [PostsLoading -> PostsLoadFailure] when unsuccess',
        build: () {
          when(
            mockGetPostsUsecase.execute(),
          ).thenAnswer((realInvocation) async =>
              Left(RemoteFailure(ServerExceptionType.unexpectedError.name)));

          return PostsBloc(mockGetPostsUsecase, mockGetCommentsByPostIdUsecase);
        },
        act: (bloc) => bloc.add(GetPosts()),
        expect: () => [
          PostsLoading(),
          PostsLoadFailure(message: ServerExceptionType.unexpectedError.name),
        ],
        verify: (_) => verify(mockGetPostsUsecase.execute()).called(1),
      );
    },
  );
}
