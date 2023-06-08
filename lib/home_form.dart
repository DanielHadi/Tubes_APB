import 'package:flutter/material.dart';

class HomeForm extends StatelessWidget {
  const HomeForm({Key? key});
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
  late IconData _selectedIcon;

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
                'Lokasi',
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
                    return 'Please enter the location';
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
              SizedBox(height: 16.0),
              
              Text(
                'Suhu',
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
                    return 'Please enter the temperature';
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
                'Status',
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
                    return 'Please enter the status';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
                
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