import 'package:flutter/material.dart';
import 'package:quantum_it_flutter_assignment/common/utils/logout_dialog.dart';
import 'package:quantum_it_flutter_assignment/common/widgets/custom_news_tile.dart';
import 'package:quantum_it_flutter_assignment/models/article_model.dart';
import 'package:quantum_it_flutter_assignment/services/auth_service.dart';
import 'package:quantum_it_flutter_assignment/services/news_api_service.dart';
import 'package:quantum_it_flutter_assignment/views/auth_view.dart';

enum MenuAction { logout }

class NewsListView extends StatefulWidget {
  const NewsListView({super.key});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  final newsApiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Feed"),
        elevation: 3,
        actions: [
          PopupMenuButton<MenuAction>(
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text("Logout"),
                ),
              ];
            },
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  if (shouldLogout) {
                    await AuthService.instance.logOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const AuthView(),
                      ),
                    );
                  }
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: newsApiService.getArticles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return customNewsTile(articles[index], context);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
