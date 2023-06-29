import 'package:crud_app/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/posts_models.dart';

class PostListScreen extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crud App'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: postController.posts.length,
          itemBuilder: (context, index) {
            final post = postController.posts[index];
            return ListTile(
              title: Text(
                post.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              subtitle: Text(post.body),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreatePostDialog(context);
        },
        child: Icon(Icons.add),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            postController.fetchPosts();
          },
          child: Text('Refresh'),
        ),
        ElevatedButton(
          onPressed: () {
            showUpdatePostDialog(context);
          },
          child: Text('Update'),
        ),
        ElevatedButton(
          onPressed: () {
            showDeletePostDialog(context);
          },
          child: Text('Delete'),
        ),
      ],
    );
  }

  void showCreatePostDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(labelText: 'Body'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String title = titleController.text;
                final String body = bodyController.text;
                if (title.isNotEmpty && body.isNotEmpty) {
                  postController.createPost(title, body);
                  Get.back();
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void showUpdatePostDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();


    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String updatedTitle = titleController.text;
                final String updatedBody = bodyController.text;
                if (updatedTitle.isNotEmpty && updatedBody.isNotEmpty) {

                  Get.back();
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void showDeletePostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Post'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {

                Get.back();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
