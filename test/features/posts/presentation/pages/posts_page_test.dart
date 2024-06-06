import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice1_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:practice1_app/features/posts/presentation/pages/posts_page.dart';

import '../../dummy/post_entity_fixture.dart';

class MockPostsBloc extends MockBloc<PostsEvent, PostsState>
    implements PostsBloc {}

void main() {
  late final MockPostsBloc mockPostsBloc;

  setUp(() {
    mockPostsBloc = MockPostsBloc();
  });

  const tPostEntities = PostEntityFixture.postEntities;

  Widget makeTestableWidget(Widget body) => BlocProvider<PostsBloc>(
        create: (context) => mockPostsBloc,
        child: MaterialApp(
          home: body,
        ),
      );

  testWidgets(
    'should show posts in [ListView.builder()] when state is [PostsLoadSuccess]',
    (t) async {
      // arrange
      when(() => mockPostsBloc.state)
          .thenReturn(const PostsLoadSuccess(posts: tPostEntities));

      // act
      await t.pumpWidget(makeTestableWidget(const PostsPage()));
      await t.pumpAndSettle();

      // assert
      var lvPosts = find.byKey(const Key('post_data'));
      expect(lvPosts, findsOneWidget);
    },
  );
}
