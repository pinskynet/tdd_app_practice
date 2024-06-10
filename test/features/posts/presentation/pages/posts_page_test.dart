import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice1_app/core/di/injection.dart';
import 'package:practice1_app/core/go_routers/go_router.dart';
import 'package:practice1_app/core/go_routers/routes.dart';
import 'package:practice1_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:practice1_app/features/posts/presentation/pages/post_comments_page.dart';
import 'package:practice1_app/features/posts/presentation/pages/posts_page.dart';

import '../../../../helpers/pump_app_router.dart';
import '../../dummy/post_entity_fixture.dart';

class MockPostsBloc extends MockBloc<PostsEvent, PostsState>
    implements PostsBloc {}

void main() {
  late MockPostsBloc mockPostsBloc;

  setUp(() {
    mockPostsBloc = MockPostsBloc();
    HttpOverrides.global = null;
  });

  const tPostEntities = PostEntityFixture.postEntities;

  Widget makeTestableWidget() => BlocProvider<PostsBloc>(
        create: (context) => mockPostsBloc,
        child: const MaterialApp(
          home: PostsPage(),
        ),
      );

  testWidgets(
    'should show [SizedBox] when state is [PostsInitial]',
    (t) async {
      // arrange
      when(() => mockPostsBloc.state).thenReturn(PostsInitial());

      // act
      await t.pumpWidget(makeTestableWidget());

      // expect
      var sizedBox = find.byType(SizedBox);
      expect(sizedBox, findsOneWidget);
    },
  );

  testWidgets(
    'should show [CircularProgressIndicator] when state is [PostsLoading]',
    (t) async {
      WidgetsFlutterBinding.ensureInitialized();

      // arrange
      when(() => mockPostsBloc.state).thenReturn(PostsLoading());

      // act
      await t.pumpWidget(makeTestableWidget());

      // expect
      var loading = find.byType(CircularProgressIndicator);
      expect(loading, findsOneWidget);
    },
  );

  testWidgets(
    'should show posts in [ListView.builder()] when state is [PostsLoadSuccess]',
    (t) async {
      // arrange
      when(() => mockPostsBloc.state)
          .thenReturn(const PostsLoadSuccess(posts: tPostEntities));

      // act
      await t.pumpWidget(makeTestableWidget());
      await t.pumpAndSettle();

      // assert
      var lvPosts = find.byKey(const Key('post_data'));
      expect(lvPosts, findsOneWidget);
    },
  );

  testWidgets('is redirected when button is tapped', (tester) async {
    // arrange
    when(() => mockPostsBloc.state)
        .thenReturn(const PostsLoadSuccess(posts: tPostEntities));

    await tester.pumpRouterApp(
      BlocProvider<PostsBloc>(
        create: (context) => mockPostsBloc,
        child: const PostsPage(),
      ),
    );

    expect(find.byType(ListTile).first, findsOneWidget);

    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();
    expect(find.byKey(Key(tester.getRouterKey(RoutePaths.comments))),
        findsOneWidget);
  });

  // testWidgets('should direct to post comments when clicking on first post',
  //     (t) async {
  //   final mockGoRouter = MockGoRouter();

  //   // arrange
  //   when(() => mockPostsBloc.state)
  //       .thenReturn(const PostsLoadSuccess(posts: tPostEntities));

  //   // act
  //   await t.pumpWidget(BlocProvider<PostsBloc>(
  //     create: (context) => mockPostsBloc,
  //     child: MaterialApp(
  //       home: InheritedGoRouter(
  //         goRouter: MyGoRouter.router(),
  //         child: const PostsPage(),
  //       ),
  //     ),
  //   ));

  //   var firstPost = find.byType(ListTile).first;
  //   expect(firstPost, findsOneWidget);

  //   await t.tap(firstPost);
  //   await t.pumpAndSettle();

  //   expect(find.byType(PostCommentsPage), findsOneWidget);

  //   // verify(() => mockGoRouter.pushNamed(
  //   //       'comments',
  //   //       pathParameters: {
  //   //         "postId": tPostEntities.first.id.toString(),
  //   //       },
  //   //     )).called(1);
  //   // verify(() => mockGoRouter.go('/comments')).called(1);
  //   // verifyNever(() => mockGoRouter
  //   //     .go('/comments/${tPostEntities.elementAt(1).id.toString()}'));
  //   // // verifyNever(() => mockGoRouter.pushNamed(
  //   // //       'comments',
  //   // //       pathParameters: {
  //   // //         "postId": tPostEntities.elementAt(1).id.toString(),
  //   // //       },
  //   // //     ));
  // });
}
