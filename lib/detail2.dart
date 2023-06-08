import 'package:flutter/material.dart';

class Detail2 extends StatelessWidget {
  const Detail2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            '60',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kualitas Udara'),
                      Text(
                        'Sedang',
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
              children: const <Widget>[
                ListTile(title: Text('Kelembapan'), trailing: Text('83%')),
                ListTile(title: Text('Angin'), trailing: Text('3.1 m/s')),
                ListTile(title: Text('Tekanan'), trailing: Text('1011 mb')),
              ],
            ),
          ],
        ));
  }
}
