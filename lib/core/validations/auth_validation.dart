class ValidateData{
  static bool validateEmail(String? value) {
    if (value == null){return false;}
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
  static String? validatePassword(String? value) {
    // r'^
    //   (?=.*[A-Z])       // should contain at least one upper case
    //   (?=.*[a-z])       // should contain at least one lower case
    //   (?=.*?[0-9])      // should contain at least one digit
    //   (?=.*?[!@#\$&*~]) // should contain at least one Special character
    //     .{6,}             // Must be at least 8 characters in length
    // $
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regex =  RegExp(pattern.toString());
    if (value != null){
      if (value.isEmpty) {
        return "Please enter password";
      } else if (value.length < 8) {
        return 'length should be at least 8';
      } else {
        if (!regex.hasMatch(value)) {
          return '#, uppercase char,lowercase char, [!@#\$&*~]';
        }
      }
    }
    return null;
  }
}