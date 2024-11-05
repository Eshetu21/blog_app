part of 'blog_bloc.dart';

sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSucess extends BlogState {}

final class BlogDiplaySucess extends BlogState {
  final List<Blog> blogs;

  BlogDiplaySucess(this.blogs);
}

final class BlogFailure extends BlogState {
  final String error;

  BlogFailure(this.error);
}
