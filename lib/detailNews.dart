import 'package:flutter/material.dart';

class DetailNews extends StatelessWidget {
  const DetailNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail News'),
          backgroundColor: Color.fromARGB(255, 93, 100, 115),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  child: Text(
                    'Cuaca di Bojongsoang Hari Ini',
                  )),
              DefaultTextStyle(
                  style: TextStyle(fontSize: 12, color: Colors.black),
                  child: Text('Syahdee - 15 Feb')),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://www.infoplease.com/sites/infoplease.com/files/styles/scale800w/public/daily-images/Weather-of-the-Day.jpg?itok=An4IRbv1"))),
                height: screenHeight / 3,
                margin: EdgeInsets.all(8),
              ),
              const SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: DefaultTextStyle(
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          child: Text(
                              'Cuaca hari ini sangatlah tidak jelas. Banyak sekali burung berterbangan di sekitar area danau galau.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nam consequat, mauris id tincidunt dictum, purus lectus pharetra metus, ac rhoncus lorem orci eu purus. Sed eros tellus, congue ac aliquet sit amet, tristique eget purus. Integer maximus lacus congue, porttitor augue id, porttitor augue. Nulla nec lorem congue, rhoncus ante vitae, hendrerit leo. Integer at sodales risus, sed vehicula lorem. Pellentesque non pellentesque purus, non pretium sapien. Phasellus a tortor neque. Curabitur vel rhoncus tortor. Morbi eu lacus sit amet libero facilisis eleifend. Curabitur neque ex, mattis eget sagittis quis, iaculis sed diam.'))))
            ],
          ),
        ));
  }
}
