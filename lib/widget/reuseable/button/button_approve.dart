import 'package:flutter/material.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';
import 'package:mt/resource/values/values.dart';

class approveButton extends StatelessWidget {

  final Stream<dynamic> stream;
  final String title;
  final int ticketId;
  final int statusId;
  final int approval;
  final Function doUpdate;
  final Function closeCallback;


  approveButton({
    this.stream,
    this.title,
    this.ticketId,
    this.statusId,
    this.approval,
    this.doUpdate,
    this.closeCallback,
  });

  Widget confirm(BuildContext context, String id, String name){
    showModalBottomSheet(
        enableDrag: true,
        context: context,
        builder: (builder) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.0,top: 100.0,right: 50.0,bottom: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('CONFIRM', style: TextStyle(fontWeight: FontWeight.bold,),),
                      SizedBox(height: 10.0,),
                      Text("Are you sure sent to "+name+" ?"),
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
                      closeCallback();
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
                      doUpdate(approval, ticketId, id);
                    },
                    child: SizedBox(
                      height: kToolbarHeight,
                      width: 100,
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('PROCEED', style: TextStyle(
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
  }

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
                          // Show confirmation dialog
                          showModalBottomSheet(
                              barrierColor: Colors.transparent,
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
                                            Text(
                                              statusId == 1 ? 'APPROVAL 1' :
                                              statusId == 2 ? 'APPROVAL 2' :
                                              statusId == 3 ? 'APPROVAL 3' :
                                              statusId == 4 ? 'FINAL APPROVE' :
                                              statusId == 5 ? 'COMPLETED' :
                                              statusId == 6 ? 'REJECTED' :
                                              'Error',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),),
                                            Text('CONFIRM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
                                            SizedBox(height: 10.0,),
                                            Text("Are you sure sent to "+name.data+" ?", style: TextStyle(fontSize: 18),),
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
                                                      ticketBloc.resetBloc();
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
                                                      doUpdate(approval, ticketId, streamData.data);
                                                    },
                                                    child: SizedBox(
                                                      height: kToolbarHeight,
                                                      width: 100,
                                                      child: Center(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text('PROCEED', style: TextStyle(
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
