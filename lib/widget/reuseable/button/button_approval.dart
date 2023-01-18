import 'package:flutter/material.dart';

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

              // print(idapproval.toString());
              // print(ticketId.toString());
              // print(snapshot.data);
              doUpdate(idapproval, ticketId, snapshot.data);
            }
                : null,
            child: Row(
              children: [
                Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
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
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
