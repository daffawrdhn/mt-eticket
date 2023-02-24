import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class skeletonTicket extends StatelessWidget {
  skeletonTicket();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
        ),
        child: Container(
          color: Colors.white.withOpacity(0.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 37.0),
            child: SkeletonItem(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 4.0, right: 18.0),
                          child: SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                shape: BoxShape.circle, width: 32, height: 32),
                          ),
                        ),
                        Expanded(
                          child: SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                                lines: 6,
                                spacing: 6,
                                lineStyle: SkeletonLineStyle(
                                  randomLength: true,
                                  height: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  minLength: MediaQuery.of(context).size.width / 6,
                                  maxLength: MediaQuery.of(context).size.width / 3,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, right: 14.0),
                          child: SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                shape: BoxShape.circle, width: 32, height: 32),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}
