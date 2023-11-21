import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


import '../utils/color_utils.dart';


class VideoCard extends StatefulWidget {
  const VideoCard({super.key});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Videos"),
      ),
      body: Container(

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Temas/Vyp6BC3DR7P4xKYJyNwG/vd').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              List<DocumentSnapshot> docs = snapshot.data!.docs;
              return PageView.builder(
                itemCount: docs.length,
                controller: PageController(

                ),
                itemBuilder: (context, index) {
                  final DocumentSnapshot vd = docs[index];
                  YoutubePlayerController _ytcontrol =
                  YoutubePlayerController(initialVideoId: vd['Url'].toString());
                  return Container(
                    decoration: BoxDecoration(
                      //color: Colors.cyan
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 90, horizontal: 15),
                          child: YoutubePlayerBuilder(
                            player: YoutubePlayer(
                              controller: _ytcontrol,
                            ),
                            builder: (context, player) {
                              return Column(
                                children: [
                                  // some widgets
                                  player,

                                  //some other widgets
                                ],
                              );
                            },
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Text(
                            vd['Descripcion'],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}