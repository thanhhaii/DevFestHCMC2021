class Validate{
  static String emailValidate = r'/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i';
  static bool checkValidate(String regStr,inputStr){
    // RegExp regExp = RegExp(regStr);
    // return regExp.hasMatch(inputStr);
    return true;
  }
}