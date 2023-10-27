import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videos extends StatefulWidget {

  final String idTem;

  const Videos({super.key, required this.idTem});

  @override
  State<Videos> createState() => _VideosState(this.idTem);
}

class _VideosState extends State<Videos> {
  String idTem;

  _VideosState(this.idTem);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Videos"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Temas/'+idTem+'/vd').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot vd = docs[index];
                YoutubePlayerController _ytcontrol =
                YoutubePlayerController(initialVideoId: vd['Url'].toString());
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: YoutubePlayer(
                          controller: _ytcontrol,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: Text(
                          vd['Descripcion'],
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
