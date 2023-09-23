import 'dart:math';

import 'package:intl/intl.dart';

extension StringExtensions on String {


  String toImageName() {
    if (isEmpty) {
      return this;
    }

    List<String> nameParts = split(' ');
    if (nameParts.isNotEmpty) {
      String initials = '';
      for (String part in nameParts) {
        initials += part.isNotEmpty ? part[0] : '';
      }
      return initials.toUpperCase();
    }

    return this;
  }

  String toCapitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    final trimmedString = trim();
    final firstNonSpaceIndex = trimmedString.indexOf(RegExp(r'\S'));
    if (firstNonSpaceIndex == -1) {
      // The string contains only spaces
      return this;
    }
    return substring(0, firstNonSpaceIndex) +
        trimmedString[firstNonSpaceIndex].toUpperCase() +
        trimmedString.substring(firstNonSpaceIndex + 1);
  }

  String toDateDMMM(){
    try{
      return (DateFormat('d MMM').format(DateTime.parse(this))).toUpperCase();
    }catch (e){
      return this;
    }
  }

  String toDateDMMMY(){
    try{
      return DateFormat('d MMM, y').format(DateTime.parse(this));
    }catch (e){
      return this;
    }
  }

  String toDateDMMMYY(){
    try{
      return (DateFormat('d MMM, yy').format(DateTime.parse(this))).toUpperCase();
    }catch (e){
      return this;
    }
  }

  String toDateMMMMYYYY(){
    try{
      return DateFormat('MMMM, yyyy').format(DateTime.parse(this));
    }catch (e){
      return this;
    }
  }

  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }


  String toTime(){
    try{
      return DateFormat('h:mm a').format(DateTime.parse(this));
    }catch (e){
      return "?";
    }
  }
}
