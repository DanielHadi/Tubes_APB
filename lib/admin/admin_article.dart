import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newhome/admin/article_add_form.dart';
import 'package:newhome/admin/article_update_form.dart';
import 'package:newhome/screens/signin_screen.dart';

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

class AdminArticlePage extends StatefulWidget {
  const AdminArticlePage({Key? key}) : super(key: key);

  @override
  _AdminArticlePage createState() => _AdminArticlePage();
}

class _AdminArticlePage extends State<AdminArticlePage> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    final currentContext = context;

    return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Today's News"),
            backgroundColor: Color.fromARGB(255, 93, 100, 115),
            automaticallyImplyLeading: false,
            actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                });
                // Tambahkan logika untuk mengarahkan pengguna ke halaman login atau halaman lain yang sesuai setelah logout
              },
            ),
          ],
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ArticleAddForm();
              }));
            },
            backgroundColor: Color.fromARGB(255, 93, 100, 115),
            child: const Icon(Icons.add),
          ),
        )
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
              context,
              MaterialPageRoute(
                  builder: (context) => ArticleUpdateForm(
                        article: article,
                      )));
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Hapus Artikel'),
                  content: const Text('Anda yakin?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        deleteArticle(article,context);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              });
        },
      );

  Stream<List<Article>> readArticle() => FirebaseFirestore.instance
      .collection('article')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Article.fromJson(doc.data())).toList());

  void deleteArticle(Article article, BuildContext context) {
    FirebaseFirestore.instance.collection('article').doc(article.id).delete();
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text('Artikel berhasil dihapus!')),
    );
  }
}
