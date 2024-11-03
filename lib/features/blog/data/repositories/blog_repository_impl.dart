import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);
  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        file: image,
        blog: blogModel,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return Right(uploadedBlog);
    } on ServerException catch (e) {
      print("ServerException in uploadBlog: ${e.message}");
      return Left(ServerFailure(e.message));
    } catch (e) {
      print("Unexpected exception in uploadBlog: $e");
      return Left(Failures("An unexpected error occurred"));
    }
  }
}
