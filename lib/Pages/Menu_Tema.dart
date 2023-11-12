import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ing/Pages/HomePage.dart';
import 'package:ing/Pages/Videos.dart';

import 'nv.dart';

class MenuTema extends StatefulWidget {
  final String idTem;
  final String Tem;

  const MenuTema({super.key, required this.idTem, required this.Tem});

  @override
  State<MenuTema> createState() => _MenuTemaState(this.idTem, this.Tem);
}

class _MenuTemaState extends State<MenuTema> {
  String idTem;
  String Tem;
  CollectionReference temas = FirebaseFirestore.instance.collection('Temas');
  _MenuTemaState(this.idTem, this.Tem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aprendiendo " + Tem),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage('assets/images/logo.jpeg'),
                      ),
                    )
                  ],
                )),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("Temas"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.play_circle),
              title: Text("Ver videos"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Videos(
                      idTem: idTem,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.gamepad),
              title: Text("Memorama"),
              onTap: () {
                if (idTem.isNotEmpty) {
                  temas.doc(idTem).get().then((value) {
                    Navigator.pushNamed(context, 'game', arguments: {
                      'level': value['Nombre'].toString(),
                      'id': idTem
                    });
                  });
                }
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.play_circle),
                title: Text('Ver Videos'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Videos(idTem: idTem,),),
                  );},),
              ListTile(
                leading: Icon(Icons.gamepad),
                title: Text('Memorama'),
                onTap: () {
                  if (idTem.isNotEmpty) {
                    temas.doc(idTem).get().then((value) {
                      Navigator.pushNamed(context, 'game', arguments: {
                        'level': value['Nombre'].toString(),
                        'id': idTem
                      });});}},),
              ListTile(
                leading: Icon(Icons.gamepad),
                title: Text('Hangman'),
                onTap: () {
                  if (idTem.isNotEmpty) {
                    temas.doc(idTem).get().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => nv(
                            Tem: idTem,
                            nTem: value['Nombre'].toString(),
                          ),),);});}},)
            ],
          ),
        ),
      ),
    );
    return const Placeholder();
  }
}
