import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice1_app/features/posts/presentation/bloc/posts_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POSTS'),
        centerTitle: true,
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, s) {
          if (s is PostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (s is PostsLoadFailure) {
            return Center(
              child: Text(
                '${s.statusCode ?? ''}\n${s.message}',
                style: const TextStyle(fontSize: 30),
              ),
            );
          }
          if (s is PostsLoadSuccess) {
            return ListView.builder(
              key: const Key('post_data'),
              itemCount: s.posts.length,
              itemBuilder: (context, i) {
                final item = s.posts[i];

                return ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.body),
                  leading: Text(item.id.toString()),
                  trailing: Text('User\n${item.userId}'),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
