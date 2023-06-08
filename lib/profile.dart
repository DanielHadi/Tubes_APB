import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newhome/screens/signin_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Color.fromARGB(255, 93, 100, 115),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://cdn01.indozone.id/local/5eec7b41f0da5.jpg'),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // aksi ketika tombol edit di tekan
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Smitty WerbenJagerManJensen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star_border,
                color: Colors.yellow[700],
              ),
              SizedBox(width: 5),
              Text(
                'Premium',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tambahkan deskripsi diri Anda',
              ),
              maxLines: 3,
              maxLength: 150, // jumlah karakter maksimal
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            print("Signed Out");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          });
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.logout), Text('Log Out')]),
        backgroundColor: Color.fromARGB(255, 93, 100, 115),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
