import 'package:flutter/material.dart';
import 'detailNews.dart';

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  });

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                subtitle,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        // const Padding(padding: EdgeInsets.only(bottom: 10.0)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate - $readDuration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: AspectRatio(aspectRatio: 1.0, child: thumbnail),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's News"),
        backgroundColor: Color.fromARGB(255, 93, 100, 115),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          InkWell(
            child: CustomListItemTwo(
              thumbnail: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://www.infoplease.com/sites/infoplease.com/files/styles/scale800w/public/daily-images/Weather-of-the-Day.jpg?itok=An4IRbv1"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              title: 'Cuaca di Bojongsoang Saat Ini',
              subtitle:
                  'Cuaca hari ini sangatlah tidak jelas. Banyak sekali burung berterbangan di sekitar area danau galau.',
              author: 'Dash',
              publishDate: 'Dec 28',
              readDuration: '5 mins',
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DetailNews()));
            },
          ),
          const SizedBox(height: 10),
          CustomListItemTwo(
            thumbnail: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://static.tnn.in/photo/msid-97409514,width-100,height-200,resizemode-75/97409514.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            title: 'Top 10 Kejadian Random di Telyu, No. 4 Bikin Merinding!',
            subtitle:
                'Banyak sekali kejadian random yang ada di dunia ini. Tapi di telyu ini terdapat banyak sekali kejadian yang sangat random',
            author: 'Flutter',
            publishDate: 'Feb 26',
            readDuration: '12 mins',
          ),
          const SizedBox(height: 10),
          CustomListItemTwo(
            thumbnail: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://assets.suaramerdeka.com/crop/0x0:0x0/750x500/webp/photo/2023/03/16/hujan-plus-petir-3638355361.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            title: 'Manusia ini Tersambar Petir hingga 3 Kali!',
            subtitle:
                'Manusia bernama Aisunam pergi ke sungai untuk berburu kecoak. Namun, ketika ia berenang di lumpur petir pun menyambar ke',
            author: 'Ridhan Firdaus',
            publishDate: 'Mar 11',
            readDuration: '7 mins',
          ),
          const SizedBox(height: 10),
          CustomListItemTwo(
            thumbnail: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://mmc.tirto.id/image/otf/880x495/2021/03/18/istock-1178574687_ratio-16x9.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            title:
                '5 Fenomena Awan Aneh yang terjadi di Gotham City. No. 3 Bikin Tercengang',
            subtitle:
                'Awan merupakan kumpulan dari serapan air yang terjadi akibat penguapan dari air sekitar yang ada di daerah Gotham City.',
            author: 'Hanif Firmansyah',
            publishDate: 'Jan 15',
            readDuration: '3 mins',
          ),
          const SizedBox(height: 10),
          CustomListItemTwo(
            thumbnail: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://wahananews.co/photo/berita/dir082022/teknologi-sensor-cuaca-petani-bisa-deteksi-curah-hujan-tanah-real-time_RM2WsffLT7.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            title:
                'BIKIN KAGET! Seorang Mahasiswa membuat Sensor Jemuran Demi Menghadapi Cuaca Ekstrem',
            subtitle:
                'Seorang mahasiswa bernama Hanisya Fira berhasil membuat Elon Musk tercengang atas penemuannya yang brilian.',
            author: 'Danielsss',
            publishDate: 'Juli 23',
            readDuration: '6 mins',
          ),
          const SizedBox(height: 10),
          CustomListItemTwo(
            thumbnail: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://imgnew.outlookindia.com/uploadimage/library/16_9/16_9_5/IMAGE_1670145784.webp"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            title: 'Sukapura Menjadi Berkabut pada Dini Hari Tadi',
            subtitle:
                'Kabut turun pada pukul 3 dini hari tadi menyebabkan jarak pandang terbatas hingga 5 meter. Hal tersebut membuat warga tidak dapat beraktivitas',
            author: 'Mamank',
            publishDate: 'Sep 2',
            readDuration: '6 mins',
          ),
        ]),
      ),
    );
  }
}
