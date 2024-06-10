// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_bloc.dart';

class PostCommentsPage extends StatelessWidget {
  final int postId;

  const PostCommentsPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POST $postId'),
        centerTitle: true,
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, s) {
          if (s is CommentsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (s is CommentLoadFailure) {
            return Center(
              child: Text(
                '${s.statusCode ?? ''}\n${s.message}',
                style: const TextStyle(fontSize: 30),
              ),
            );
          }
          if (s is CommentsLoadSuccess) {
            return ListView.builder(
              key: const Key('comments_data'),
              itemCount: s.comments.length,
              itemBuilder: (context, i) {
                final item = s.comments[i];

                return ListTile(
                  title: Text("${item.name}\n${item.email}"),
                  subtitle: Text(item.body),
                  leading: Text(item.id.toString()),
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
