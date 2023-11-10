import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ing/Pages/Videos.dart';

class MenuTema extends StatefulWidget {
  final String idTem;

  const MenuTema({super.key, required this.idTem});

  @override
  State<MenuTema> createState() => _MenuTemaState(this.idTem);
}

class _MenuTemaState extends State<MenuTema> {
  String idTem;
  CollectionReference temas = FirebaseFirestore.instance.collection('Temas');
  _MenuTemaState(this.idTem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Menu"),

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.play_circle),
                title: Text('Ver Videos'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Videos(idTem: idTem,),),
                  );
                },

              ),
              ListTile(
                leading: Icon(Icons.gamepad),
                title: Text('Memorama'),
                onTap: () {
                  if (idTem.isNotEmpty) {
                    temas.doc(idTem).get().then((value) {
                      Navigator.pushNamed(context, 'game',
                          arguments: {'level': value['Nombre'].toString()});
                    });
                  }

                },
              )
            ],
          ),
        ),
      ),
    );
    return const Placeholder();
  }
}
