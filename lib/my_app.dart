import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice1_app/core/di/injection.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_posts.dart';
import 'package:practice1_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:practice1_app/features/posts/presentation/pages/posts_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => PostsBloc(getIt.get<GetPostsUsecase>())..add(GetPosts()),
        child: const PostsPage(),
      ),
    );
  }
}
