import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

void main() {
  runApp(const MaterialApp(home: MyTestApp()));
}


class MyTestApp extends StatefulWidget {
  const MyTestApp({super.key});

  @override
  State<MyTestApp> createState() => _MyTestAppState();
}

class _MyTestAppState extends State<MyTestApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          const SizedBox(height: 140,),

          CustomDropdownPopup(
            dropdownItem: [
              DropdownItem(value: "Option A"),
              DropdownItem(value: "Option A"),
            ],
            onSelected: (DropdownItem? item){

            },
          ),
          const Text("Another Views"),
          const Text("Another Views"),
          const Text("Another Views"),
          const Text("Another Views"),
          const Text("Another Views"),
          const Text("Another Views"),
          const Text("Another Views"),
          const Text("Another Views"),
        ],
      ),
    );
  }
}

class DropdownItem{
  final String value;
  final dynamic key;
  DropdownItem({required this.value,this.key});
}

class CustomDropdownPopup extends StatefulWidget {
  final Function(DropdownItem? value)? onSelected;
  final List<DropdownItem>? dropdownItem;
  final bool isExpanded;
  final BoxDecoration? decoration;
  const CustomDropdownPopup({Key? key,
    this.onSelected,
    this.dropdownItem,
    this.decoration,
    this.isExpanded = true}) : super(key: key);

  @override
  State<CustomDropdownPopup> createState() => _CustomDropdownPopupState();
}

class _CustomDropdownPopupState extends State<CustomDropdownPopup> {
  bool _isDropdownOpen = false;

  void _toggleDropdown({bool? isClose}) {
    setState(() {
      _isDropdownOpen = isClose ?? !_isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (_isDropdownOpen) {
              _toggleDropdown(isClose: true);
            } else {
              FocusScope.of(context).unfocus(); // Close keyboard if open
              _toggleDropdown(isClose: false);
            }
          },
          child: Container(
            width: 1000,
            height: 1000,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _toggleDropdown,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: widget.decoration ?? BoxDecoration(
                  color: AppColors.whiteColor(),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select',
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down_circle, color: Theme.of(context).hintColor),
                  ],
                ),
              ),
            ),
            if (_isDropdownOpen)
              Container(
                width: 200,
                height: 150,
                color: Colors.white,
                child: ListView(
                  children: [
                    for (int i = 0; i < (widget.dropdownItem?.length ?? 0); i++) ...[
                      InkWell(
                        onTap: () {
                          _toggleDropdown(isClose: false);
                          if (widget.onSelected != null) {
                            widget.onSelected!(widget.dropdownItem![i]);
                          }
                        },
                        child: Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(widget.dropdownItem![i].value),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}



// class _CustomDropdownPopupState extends State<CustomDropdownPopup> {
//
//   bool _isDropdownOpen = false;
//
//   void _toggleDropdown({ bool? isClose }) {
//     setState(() {
//       _isDropdownOpen = isClose ?? !_isDropdownOpen;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             if(widget.isExpanded)...[
//               Expanded(
//                 child: GestureDetector(
//                   onTap: _toggleDropdown,
//                   child: Container(
//                     padding: const EdgeInsets.all(15),
//                     decoration: widget.decoration ?? BoxDecoration(
//                         color: AppColors.whiteColor(),
//                         borderRadius: const BorderRadius.all(Radius.circular(10))
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Select',
//                         style: TextStyle(
//                           color: Theme.of(context).hintColor
//                         ),),
//                         Icon(Icons.arrow_drop_down_circle,color: Theme.of(context).hintColor)
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ]else...[
//               GestureDetector(
//                 onTap: _toggleDropdown,
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     border: Border.all(),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: const Text('Open'),
//                 ),
//               ),
//             ],
//           ],
//         ),
//
//        if(_isDropdownOpen)
//         Container(
//           width: 200,
//           height: 150,
//           color: Colors.white,
//           child: ListView(
//             children: [
//               for(int i= 0;i < (widget.dropdownItem?.length??0);i++)...[
//                 InkWell(
//                   onTap: (){
//                     _toggleDropdown(isClose: false);
//                     if(widget.onSelected != null){
//                       widget.onSelected!(widget.dropdownItem![i]);
//                     }
//                   },
//                   child: Container(
//                       height: 45,
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(widget.dropdownItem![i].value),
//                         ],
//                       )),
//                 ),
//               ]
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }