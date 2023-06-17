import 'package:flutter/material.dart';
import 'detail2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 49, 63, 78), Color(0xffbdc3c7)])),
      child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('home')
                  .doc('kondisi')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.data() as Map<String, dynamic>?;

                  if (data != null) {
                    var lokasi = data['lokasi'];
                    var tanggal = data['tanggal'];
                    var imgPath = data['imgPath'];
                    var suhu = data['suhu'];
                    var status = data['status'];

                    return Positioned(
                      top: MediaQuery.of(context).size.height / 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36.0,
                                  fontWeight: FontWeight.bold),
                              child: Text(lokasi), //lokasi
                            ),
                          ),
                          DefaultTextStyle(
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                            child: Text(tanggal), //tanggal
                          ),
                          Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Image.asset(
                                imgPath,
                                scale: 1.5,
                              )),
                          DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                            ),
                            child: Text(suhu),
                          ),
                          Padding(
                              padding: EdgeInsets.all(5.0),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                                child: Text(status),
                              )),
                        ],
                      ),
                    );
                  } else {
                    return Text('No Data Available');
                  }
                } else if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Detail2(),
                      actions: [
                        TextButton(
                            child: Text(
                              'Close',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ],
                    );
                  });
            },
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.07,
            minChildSize: 0.07,
            expand: true,
            builder: (BuildContext c, s) {
              return Scaffold(
                body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      controller: s,
                      children: <Widget>[
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            height: 8,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 93, 100, 115),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        )),
                        Material(
                            child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(8)),
                                  title: const Text(
                                    '15.00',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: const Text(
                                    'Hujan',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  trailing:
                                      Image.asset('weather-icons/ModRain.png'),
                                  tileColor: Color.fromARGB(255, 93, 100, 115),
                                ))),
                        Material(
                            child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(8)),
                                  title: const Text('16.00',
                                      style: TextStyle(color: Colors.white)),
                                  subtitle: const Text('Hujan Deras',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                  trailing: Image.asset(
                                      'weather-icons/CloudRainThunder.png'),
                                  tileColor: Color.fromARGB(255, 93, 100, 115),
                                ))),
                        Material(
                            child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(8)),
                                  title: const Text('17.00',
                                      style: TextStyle(color: Colors.white)),
                                  subtitle: const Text('Hujan Deras',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                  trailing: Image.asset(
                                      'weather-icons/CloudRainThunder.png'),
                                  tileColor: Color.fromARGB(255, 93, 100, 115),
                                ))),
                        Material(
                            child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(8)),
                                  title: const Text('18.00',
                                      style: TextStyle(color: Colors.white)),
                                  subtitle: const Text('Hujan Ringan',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                  trailing: Image.asset(
                                      'weather-icons/OccLightRain.png'),
                                  tileColor: Color.fromARGB(255, 93, 100, 115),
                                ))),
                        Material(
                            child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(8)),
                                  title: const Text('19.00',
                                      style: TextStyle(color: Colors.white)),
                                  subtitle: const Text('Cerah Berawan',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                  trailing: Image.asset(
                                      'weather-icons/PartlyCloudyNight.png'),
                                  tileColor: Color.fromARGB(255, 93, 100, 115),
                                )))
                      ],
                    )),
              );
            },
          )
        ],
      ),
    ));
  }
}
