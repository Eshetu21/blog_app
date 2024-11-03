import 'dart:io';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements Usecase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failures, Blog>> call(UploadBlogParams params) async {
    try {
      final result = await blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        posterId: params.posterId,
        topics: params.topics,
      );
      result.fold(
        (failure) => print("UploadBlog failed with: ${failure.message}"),
        (success) => print("UploadBlog succeeded with blog ID: ${success.id}"),
      );
      return result;
    } catch (e) {
      return Left(ServerFailure("An error occurred while uploading the blog"));
    }
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams(
      {required this.posterId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});
}
