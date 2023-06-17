import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin_article.dart';
import 'article_add_form.dart';

class ArticleUpdateForm extends StatelessWidget {
  final Article article;

  const ArticleUpdateForm({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Article',
      home: BookDetailsForm(article: article,),
    );
  }
}

class BookDetailsForm extends StatefulWidget {
  final Article article;

  const BookDetailsForm({Key? key, required this.article}) : super(key: key);

  @override
  _BookDetailsFormState createState() =>_BookDetailsFormState(article: article);
}

class _BookDetailsFormState extends State<BookDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final author = TextEditingController();
  final title = TextEditingController();
  final readDuration = TextEditingController();
  final desc = TextEditingController();
  final imgLink = TextEditingController();

  Article article;
  _BookDetailsFormState({required this.article});

  @override
  void initState() {
    super.initState();

    author.text = article.author;
    title.text = article.title;
    readDuration.text = article.readDuration;
    desc.text = article.desc;
    imgLink.text = article.imgLink;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Update Article'),
        backgroundColor: Color.fromARGB(255, 93, 100, 115),
      ),
      body: 
      ListView(
        children: [
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
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Color.fromARGB(255, 146, 157, 181);
                            }
                            return Color.fromARGB(255, 93, 100, 115);
                          }),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Process the form data, e.g., save it to a database
                            // or pass it to another screen.
                            // You can access the form fields using the variables:
                            // _author, _title, _readDuration, _description
                            final article = Article(
                                id: this.article.id.toString(),
                                author: author.text,
                                title: title.text,
                                readDuration: readDuration.text,
                                desc: desc.text,
                                imgLink: imgLink.text);

                            updateArticle(article);
                            ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Artikel berhasil diupdate!'))
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
                        child: Text('Update'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
    );
  }

  Future<void> updateArticle(Article article) async {
    final docArticle =
        FirebaseFirestore.instance.collection('article').doc(article.id);
    final json = article.toJson();

    await docArticle.update(json);
  }
}
