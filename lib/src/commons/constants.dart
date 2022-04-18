const kAnimationDuration = Duration(milliseconds: 200);

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Vui lòng nhập email";
const String kInvalidEmailError = "Email không đúng định dạng";
const String kPassNullError = "Vui lòng nhập mật khẩu";
const String kShortPassError = "Mật khẩu quá ngắn";
const String kMatchPassError = "Mật khẩu không trùng nhau";
const String kNamelNullError = "Vui lòng nhập tên của bạn";
const String kPhoneNumberNullError = "Vui lòng nhập số điện thoại";

const String KEY_REMEMBER_LOGIN = "KEY_REMEMBER_LOGIN";
const String KEY_EMAIL = "KEY_EMAIL";
const String KEY_PASSWORD = "KEY_PASSWORD";
const String KEY_CURRENT_USER = "KEY_CURRENT_USER";
const String KEY_THEME_MODE = "KEY_THEME_MODE";

const String HIVEBOX = "smartenvironment";
