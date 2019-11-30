import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final bd=Firestore.instance;

main() => runApp(Nube());
class Nube extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Estado();
  }
}

class Estado extends State{
  final txtMensaje = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primaryColor: Colors.green
      ),

      home:  Scaffold(
        appBar:  AppBar(
          title:
          Text('Servicios en la nube')
        ),
        body:

            Column(children: <Widget>[
              StreamBuilder(
                stream: Firestore.instance.collection('whatsapp').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData) return Text('Cargando datos');
                  return ListView(
                    children: <Widget>[
                      Card(child: ListTile(title: Text(snapshot.data.documents[0]['mensaje']))),
                      Card(child: ListTile(title: Text(snapshot.data.documents[1]['mensaje']))),
                      Card(child: ListTile(title: Text(snapshot.data.documents[2]['mensaje']))),
                      Card(child: ListTile(title: Text(snapshot.data.documents[3]['mensaje']))),
                    ],
                  );

                },
              ),
              Expanded(
                child: Material(
                  child: Text('    '),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Escribe un mensaje'
                )
              )
            ],
            ),


         floatingActionButton: FloatingActionButton(
            onPressed: (){
            insertar (txtMensaje.text);
          },
            child: Icon(Icons.send)
          ),

      ),
    );
  }

  void insertar(String mensaje)async {
    await bd.collection("whatsapp").add({'mensaje': mensaje});
  }

}

