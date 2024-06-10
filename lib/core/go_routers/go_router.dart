import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice1_app/core/di/injection.dart';
import 'package:practice1_app/core/go_routers/routes.dart';
import 'package:practice1_app/features/posts/presentation/pages/post_comments_page.dart';
import 'package:practice1_app/features/posts/presentation/pages/posts_page.dart';

import '../../features/posts/presentation/bloc/posts_bloc.dart';

class MyGoRouter {
  static GoRouter router([String? initialLocation]) => GoRouter(
        routes: [
          GoRoute(
            path: RoutePaths.posts,
            builder: (_, s) => BlocProvider(
              create: (context) => getIt<PostsBloc>()..add(GetPosts()),
              child: const PostsPage(),
            ),
          ),
          GoRoute(
            path: RoutePaths.comments,
            builder: (context, state) {
              final int postId = state.extra as int;
              return BlocProvider(
                create: (context) => getIt<PostsBloc>()
                  ..add(GetCommentsByPostId(postId: postId)),
                child: PostCommentsPage(
                    key: const Key('comments'), postId: postId),
              );
            },
          ),
        ],
        errorBuilder: (_, s) => const Scaffold(
          body: Center(
            child: Text('Page not found'),
          ),
        ),
      );
}
