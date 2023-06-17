import 'package:flutter/material.dart';
import 'package:newhome/admin/article_add_form.dart';

class DetailNews extends StatelessWidget {
  final Article article;

  const DetailNews({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail News'),
          backgroundColor: Color.fromARGB(255, 93, 100, 115),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DefaultTextStyle(
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Text(
                    article.title,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DefaultTextStyle(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  child: Text('by ${article.author}'),
                ),
              ),
              Divider(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(article.imgLink),
                  ),
                ),
                height: screenHeight / 3,
                margin: EdgeInsets.all(8),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultTextStyle(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    child: Text(article.desc),
                  ),
                ),
              ),
            ],
          )
        ));
  }
}
