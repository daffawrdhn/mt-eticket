import 'package:flutter/material.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';

class approvalButton extends StatelessWidget {

  final Stream<dynamic> stream;
  final String title;
  final int ticketId;
  final int idapproval;
  final Function doUpdate;

  approvalButton({
     this.stream,
     this.title,
     this.ticketId,
     this.idapproval,
     this.doUpdate,
  });

  bool close;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Visibility(
          visible: snapshot.hasData,
          child: FlatButton(
            color: Colors.blue,
            onPressed: snapshot.hasData
                ? () async {

              // Show confirmation dialog
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirmation"),
                    content: Text("Are you sure you "+title+" ?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          close = false;
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text("Proceed"),
                        onPressed: () {
                          close = true;
                          Navigator.of(context).pop();
                          doUpdate(idapproval, ticketId, snapshot.data);
                        },
                      ),
                    ],
                  );
                },
              );
              if(close == false){
              } else {
                close = null;
                Navigator.of(context).pop();
              }

            } : null,
            child: Row(
              children: [
                Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          replacement: FlatButton(
            color: Colors.grey,
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
