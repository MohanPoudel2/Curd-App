import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'models/posts_models.dart';

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      posts.value = responseData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<void> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: jsonEncode({'title': title, 'body': body}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final Post newPost = Post.fromJson(responseData);
      posts.add(newPost);
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<void> updatePost(int postId, String title, String body) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'),
      body: jsonEncode({'title': title, 'body': body}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final updatedPost = Post.fromJson(responseData);
      final index = posts.indexWhere((post) => post.id == updatedPost.id);
      if (index != -1) {
        posts[index] = updatedPost;
      }
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int postId) async {
    final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'));
    if (response.statusCode == 200) {
      posts.removeWhere((post) => post.id == postId);
    } else {
      throw Exception('Failed to delete post');
    }
  }
}
