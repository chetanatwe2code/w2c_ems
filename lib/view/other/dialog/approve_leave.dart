import 'package:flutter/material.dart';

import '../animation/show_animated_dialog.dart';

// rejectLeave

Future<void> approveLeave(BuildContext context, String name, { Function? onPressed }) async {
  await showAnimatedDialog(
      context,
      Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                top: 5,
                child: Row(
                  children: const [
                    Text("Are you Sure?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Are you Sure Approve Leave? to $name",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('NO', style: TextStyle(
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if(onPressed != null){
                              onPressed();
                            }
                          },
                          child: Text(
                            'YES',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
}