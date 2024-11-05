import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final GetAllBlog getAllBlog;
  BlogBloc({required this.getAllBlog, required this.uploadBlog})
      : super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final res = await uploadBlog(UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));
    res.fold((l) {
      print("bloc: failed to  upload");
      emit(BlogFailure(l.message));
    }, (r) {
      print("bloc: sucessfuly uploaded");
      emit(BlogSucess());
    });
  }

  void _onFetchAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final res = await getAllBlog(NoParams());
    res.fold(
        (l) => emit(BlogFailure(l.message)), (r) => emit(BlogDiplaySucess(r)));
  }
}
