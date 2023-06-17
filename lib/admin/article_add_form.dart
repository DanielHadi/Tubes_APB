import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin_article.dart';

class ArticleAddForm extends StatelessWidget {
  const ArticleAddForm({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Article',
      home: BookDetailsForm(),
    );
  }
}

class BookDetailsForm extends StatefulWidget {
  @override
  _BookDetailsFormState createState() => _BookDetailsFormState();
}

class _BookDetailsFormState extends State<BookDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final author = TextEditingController();
  final title = TextEditingController();
  final readDuration = TextEditingController();
  final desc = TextEditingController();
  final imgLink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Add Article'),
          backgroundColor: Color.fromARGB(255, 93, 100, 115),
          automaticallyImplyLeading: true,
        ),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Author',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  TextFormField(
                    controller: author,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the author';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Read Duration',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  TextFormField(
                    controller: readDuration,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the read duration';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Image Link',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  TextFormField(
                    controller: imgLink,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the image link';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  TextFormField(
                    controller: desc,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromARGB(255, 146, 157, 181);
                              }
                              return Color.fromARGB(255, 93, 100, 115);
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Process the form data, e.g., save it to a database
                            // or pass it to another screen.
                            // You can access the form fields using the variables:
                            // _author, _title, _readDuration, _description
                            final article = Article(
                                author: author.text,
                                title: title.text,
                                readDuration: readDuration.text,
                                desc: desc.text,
                                imgLink: imgLink.text);

                            createArticle(article);

                            ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Artikel berhasil ditambahkan!'))
                          );
                          }
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminArticlePage()));
                          });
                          
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]));
  }

  Future createArticle(Article article) async {
    final docArticle = FirebaseFirestore.instance.collection('article').doc();
    article.id = docArticle.id;

    final json = article.toJson();

    await docArticle.set(json);
  }
}

class Article {
  String id;
  final String author;
  final String title;
  final String readDuration;
  final String desc;
  final String imgLink;

  Article({
    this.id = '',
    required this.author,
    required this.title,
    required this.readDuration,
    required this.desc,
    required this.imgLink,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'title': title,
        'readDuration': readDuration,
        'desc': desc,
        'imgLink': imgLink
      };

  static Article fromJson(Map<String, dynamic> json) => Article(
      id: json['id'] ?? '',
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      readDuration: json['readDuration'] ?? '',
      desc: json['desc'] ?? '',
      imgLink: json['imgLink'] ?? '');
}
