import 'package:flutter/material.dart';
import 'package:newhome/admin/article_add_form.dart';
import 'detailNews.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.readDuration,
  });

  final String title;
  final String subtitle;
  final String author;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                subtitle,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$readDuration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.readDuration,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: AspectRatio(aspectRatio: 1.0, child: thumbnail),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  readDuration: readDuration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's News"),
        backgroundColor: Color.fromARGB(255, 93, 100, 115),
      ),
      body: StreamBuilder<List<Article>>(
        stream: readArticle(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final articles = snapshot.data!;

            return ListView(
              children: articles
                  .map((article) => buildArticle(article, currentContext))
                  .toList(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }

  Widget buildArticle(Article article, BuildContext context) => InkWell(
      child: CustomListItemTwo(
          thumbnail: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(article.imgLink),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          title: article.title,
          subtitle: article.desc,
          author: article.author,
          readDuration: "${article.readDuration} mins"),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailNews(article: article,)));
      });

  Stream<List<Article>> readArticle() => FirebaseFirestore.instance
      .collection('article')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Article.fromJson(doc.data())).toList());
}
