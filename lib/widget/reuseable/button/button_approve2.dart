import 'package:flutter/material.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';
import 'package:mt/resource/values/values.dart';

class approveButton2 extends StatelessWidget {
  final int approval;
  final int ticketId;
  final String employeeId;
  final Function doUpdate;
  final String title;
  final Color buttonColor;
  final Function closeCallback;

  approveButton2({
    @required this.approval,
    @required this.ticketId,
    @required this.employeeId,
    @required this.doUpdate,
    @required this.title,
    this.buttonColor = AppColors.loginSubmit,
    this.closeCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      child: Material(
        color: buttonColor,
        child: InkWell(
          onTap: () async {
            // Show confirmation dialog

            showModalBottomSheet(
                enableDrag: true,
                context: context,
                builder: (builder) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 50.0,top: 50.0,right: 50.0,bottom: 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                image: AssetImage(ImagePath.logo_h),
                                height: 100,
                              ),
                              Text(title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                              Text('CONFIRM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
                              SizedBox(height: 10.0,),

                              Visibility(visible: approval == 5, child: Text("Are you sure to reject Ticket-ID"+ticketId.toString()+" ?", style: TextStyle(fontSize: 18),),),
                              Visibility(visible: approval == 6, child: Text("Are you sure to do Ticket-ID"+ticketId.toString()+" request ?", style: TextStyle(fontSize: 16),),),
                              Visibility(visible: approval == 7, child: Text("Are you sure to set complete Ticket-ID"+ticketId.toString()+" ?", style: TextStyle(fontSize: 16),),),

                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Material(
                                    color: Colors.red,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                        height: kToolbarHeight,
                                        width: 100,
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('CANCEL', style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),)
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Material(
                                    color: AppColors.loginSubmit,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        closeCallback();
                                        doUpdate(approval, ticketId, employeeId);
                                      },
                                      child: SizedBox(
                                        height: kToolbarHeight,
                                        width: 100,
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(title, style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),)
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],),
                          ],),
                      ],
                    ),
                  );
                });
            // await showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //
            //     return AlertDialog(
            //       title: Text("Confirmation"),
            //       content: Text("Are you sure you want to "+title.toLowerCase()+" ?"),
            //       actions: <Widget>[
            //         TextButton(
            //           child: Text("Cancel",
            //             style: TextStyle(
            //                 color: AppColors.loginSubmit
            //             ),),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //         TextButton(
            //           child: Text("Proceed",
            //             style: TextStyle(
            //                 color: AppColors.loginSubmit
            //             ),),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //             doUpdate(approval, ticketId, employeeId);
            //           },
            //         ),
            //       ],
            //     );
            //   },
            // );
          },
          child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                title,
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
  }
}
