import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detail2 extends StatelessWidget {
  const Detail2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('detailHome')
          .doc('detail')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.data() as Map<String, dynamic>?;

          if (data != null) {
            var aqi = data['aqi'];
            var kualitas = data['kualitas'];
            var kelembapan = data['kelembapan'];
            var angin = data['angin'];
            var tekanan = data['tekanan'];

            return Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 2),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 238, 0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff3c519),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          width: 80.0,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              Text(
                                'Index AQI',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                aqi.toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kualitas Udara'),
                            Text(
                              kualitas,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: <Widget>[
                      ListTile(
                        title: Text('Kelembapan'),
                        trailing: Text('${kelembapan.toString()}%'),
                      ),
                      ListTile(
                        title: Text('Angin'),
                        trailing: Text('${angin.toString()} m/s'),
                      ),
                      ListTile(
                        title: Text('Tekanan'),
                        trailing: Text('${tekanan.toString()} mb'),
                      ),
                    ],
                  ),
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
    );
  }
}
