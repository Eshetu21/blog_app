part of 'blog_bloc.dart';

sealed class BlogEvent {}

class BlogUpload {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  BlogUpload(
      {required this.posterId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});
}
