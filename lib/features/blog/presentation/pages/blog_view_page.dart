import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewPage extends StatelessWidget {
  final Blog blog;
  const BlogViewPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(blog.title),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(blog.imageUrl),
              ),
              Text(blog.content)
            ],
          ),
        ),
      ),
    );
  }
}
