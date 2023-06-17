import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newhome/screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  late TextEditingController _imgLinkFieldController;
  final User? _user = FirebaseAuth.instance.currentUser;
  late String _username = "";
  late String _name = "";
  late String _email = "";
  late String _imgLink = "";

  @override
  void initState() {
    super.initState();
    _imgLinkFieldController = TextEditingController();
    _getUserData();
  }

  @override
  void dispose() {
    _imgLinkFieldController.dispose();
    super.dispose();
  }

  Future<void> _getUserData() async {
    print("Ini user id email : ${_user?.email}");
    if (_user != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _user?.email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot documentSnapshot = snapshot.docs[0];
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          _username = data['username'];
          _name = data['name'];
          _email = data['email'];
          _imgLink = data['imgLink'];
        });
      } else {
        print("Dokumen tidak ditemukan");
      }
    }
  }

  Future<void> _updateProfile() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _user!.email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      DocumentReference documentRef = snapshot.docs[0].reference;

      await documentRef.update({'imgLink': _imgLinkFieldController.text});
      await _getUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Color.fromARGB(255, 93, 100, 115),
      ),
      body: Center(
        child: Transform.translate(
          offset: Offset(0, -60), // Menggeser konten ke atas sekitar 20.dp
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(_imgLink),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 93, 100, 115),
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Ganti Profil'),
                              content: TextField(
                                controller: _imgLinkFieldController,
                                decoration:
                                    InputDecoration(hintText: 'Link Image'),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Batal'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Simpan'),
                                  onPressed: () {
                                    if (_imgLinkFieldController
                                        .text.isNotEmpty) {
                                      _updateProfile().then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Profil berhasil diperbarui!')));
                                        Navigator.of(context).pop();
                                      });
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                _username,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '$_name - $_email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            print("Signed Out");
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Berhasil Log Out!')));

            Future.delayed(const Duration(seconds: 1), () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
            });
            
          });
        },
        icon: Icon(Icons.logout),
        backgroundColor: Color.fromARGB(255, 93, 100, 115),
        label: Text("Log Out"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
