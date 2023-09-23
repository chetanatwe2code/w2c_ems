import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownModel{
  String? id;
  String? value;
  DropDownModel({required this.value,this.id});
}

class CustomDropDown extends StatefulWidget {
  final List<DropDownModel>? list;
  final String? hint;
  final double? height;
  final double? width;
  final double? dropdownWidth;
  final String? selectValue;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BoxDecoration? decoration;
  final Function(String? model)? onChanged;
  final EdgeInsetsGeometry? padding;
  const CustomDropDown({super.key,this.list,this.dropdownWidth,this.width,this.padding,this.height,this.selectValue,this.hint,this.onChanged,this.decoration,this.hintStyle,this.textStyle});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  List<DropdownMenuItem<String>> menuItems = [];

  initList(){
    menuItems.clear();
    for(int i = 0; i < (widget.list?.length??0);i++){
      menuItems.add(DropdownMenuItem<String>(
        value: widget.list![i].id ?? widget.list![i].value,
        child: Text((widget.list![i].value??"").toCapitalizeFirstLetter(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: widget.textStyle?.copyWith(
              color: AppColors.textColor(),
            fontSize: 11
          ),),
      ));
    }
  }




  @override
  Widget build(BuildContext context) {
    initList();
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: menuItems,
        value: widget.selectValue,
        onChanged: (String? v) {
          if(widget.onChanged != null){
            widget.onChanged!(v);
          }
        },
        selectedItemBuilder: (context) {
          if(widget.list?.isEmpty??true){
            return [];
          }
          return widget.list!.map((e) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(((e.value??"").toCapitalizeFirstLetter()),style: TextStyle(
                color: widget.textStyle?.color
              ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )).toList();
        },
        isExpanded: true,
        hint: Text(widget.hint ?? 'Select',style: widget.hintStyle,),
        style: widget.textStyle,
        buttonStyleData: ButtonStyleData(
          height: widget.height ?? 20,
          width: widget.width,
          decoration: widget.decoration,
          elevation: 0,
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 5),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(Icons.keyboard_arrow_up,size: 12,color: widget.textStyle?.color,)
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 300,
          width: widget.dropdownWidth ?? 120,
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          elevation: 8,
          offset: const Offset(0, 2),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: widget.height ?? 20,
          selectedMenuItemBuilder: (context,child){
            return Container(
              color: AppColors.primary.withOpacity(0.3),
              child: child,
            );
          },
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ),
    );
  }
}
