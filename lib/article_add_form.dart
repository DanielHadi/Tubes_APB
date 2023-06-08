import 'package:flutter/material.dart';

class ArticleAddForm extends StatelessWidget {
  const ArticleAddForm({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Details Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  late String _author;
  late String _title;
  late String _readDuration;
  late String _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details Form'),
      ),
      body: Padding(
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
                onSaved: (value) {
                  _author = value!;
                },
              ),
              SizedBox(height: 16,),
              Text(
                'Title',
                style: TextStyle(

                  fontSize: 16.0,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(height: 16,),
              Text(
                'Read Duration',
                style: TextStyle(

                  fontSize: 16.0,
                ),
              ),
              TextFormField(
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
                  decimal: false, signed: false
                ),
                onSaved: (value) {
                  _readDuration = value!;
                },
              ),
              SizedBox(height: 16,),
              Text(
                'Description',
                style: TextStyle(

                  fontSize: 16.0,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Process the form data, e.g., save it to a database
                        // or pass it to another screen.
                        // You can access the form fields using the variables:
                        // _author, _title, _readDuration, _description
                        print('Author: $_author');
                        print('Title: $_title');
                        print('Read Duration: $_readDuration');
                        print('Description: $_description');
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}