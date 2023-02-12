import 'package:flutter/material.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';
import 'package:mt/resource/values/values.dart';

class approveButton extends StatelessWidget {

  final Stream<dynamic> stream;
  final String title;
  final int ticketId;
  final int approval;
  final Function doUpdate;
  final Function closeCallback;


  approveButton({
    this.stream,
    this.title,
    this.ticketId,
    this.approval,
    this.doUpdate,
    this.closeCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      child: StreamBuilder(
          stream: ticketBloc.name,
          builder: (context, name){
            if (name.data != null || name.hasData){
              return StreamBuilder(
                stream: stream,
                builder: (context, streamData) {
                  return Visibility(
                    visible: streamData.hasData,
                    child: Material(
                      color: AppColors.loginSubmit,
                      child: InkWell(
                        onTap: streamData.hasData
                            ? () async {
                          closeCallback();
                          // Show confirmation dialog
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirmation"),
                                content: Text("Are you sure sent to "+name.data+" ?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("Cancel",
                                      style: TextStyle(
                                        color: Colors.red
                                      ),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Proceed",
                                      style: TextStyle(
                                        color: AppColors.loginSubmit
                                      ),),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      doUpdate(approval, ticketId, streamData.data);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } : null,
                        child: SizedBox(
                          height: kToolbarHeight,
                          width: double.infinity,
                          child: Center(
                            child: Text(title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    replacement: Material(
                      color: Colors.grey,
                      child: InkWell(
                        onTap: () {
                          // Show confirmation dialog
                        },
                        child: SizedBox(
                          height: kToolbarHeight,
                          width: double.infinity,
                          child: Center(
                            child: Text(title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Material(
              color: Colors.grey,
              child: InkWell(
                onTap: () {
                  // Show confirmation dialog
                },
                child: SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
