class Validator {
  static bool validateEmail(String? email) {
    if ((email ?? '').isEmpty) {
      return false;
    }

    return RegExp(
            r"^(([^<>()[\]\\.,;:@\']+(\.[^<>()[\]\\.,;:@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9\s]+\.)+[a-zA-Z\s]{2,}))$")
        .hasMatch(email ?? '');
  }

  static bool validatePhone(String? phone) {
    if ((phone ?? '').isEmpty) {
      return false;
    }

    return RegExp(r"^0[0-9\s]{9}$").hasMatch(phone ?? '');
  }

  static bool validateYear(String year) => RegExp(r"^\d{4}$").hasMatch(year);

  static bool validatePeopleId(String peopleId) => RegExp(r"^([0-9]{9}||[0-9]{12})$").hasMatch(peopleId);

  static bool validateReferenceCode(String ref) => RegExp(r"^\w{3}-\d{5}-\w{7}$").hasMatch(ref);

  static bool validateName(String name) =>
      RegExp(r"[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$").hasMatch(name);

  static bool validateAddress(String address) =>
      RegExp(r"(\d{0,}[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]).{2,}$").hasMatch(address);

  static bool validateIdentityCode(String identityCode) => RegExp(r"^\+?[0-9]{6,12}$").hasMatch(identityCode);

  static bool validatePassword(String? password) {
    if ((password ?? '').isEmpty) {
      return false;
    }
    return RegExp(r"^[A-Za-z\d!@#$%^&*]{8,100}$").hasMatch(password ?? '');
  }

  static String? getLinkFromText(String text) =>
      RegExp(r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&\/=]*)')
          .stringMatch(text);

  static bool accountEmpty(String value) => value.isNotEmpty;

  static bool accountLengthInvalid(String value) => RegExp(r"^[\d]{4,20}$").hasMatch(value);

  static bool accountNameIsValid(String value, String compareText) =>
      value.toUpperCase() == compareText.toUpperCase() && value.toLowerCase() == compareText.toLowerCase();

  static String? onValidateEmailOrPhone(String? e) {
    if ((e ?? '').isEmpty) {
      return ''; //S.current.common_emailPhoneNotEmpty;
    } else if (validatePhone(e) || validateEmail(e)) {
      return null;
    } else {
      return ''; //S.current.common_emailPhoneNotFormat;
    }
  }

  static String? onValidatePassword(String? p) {
    if ((p ?? '').isEmpty) {
      return ''; //S.current.common_passwordNotEmpty;
    } else if (validatePassword(p)) {
      return null;
    } else {
      return ''; //S.current.common_passwordNotFormat;
    }
  }

  static String? onValidateName(String? n) {
    if (n!.isEmpty) {
      return ''; //S.current.validators_nameEmpty;
    } else if (!validateName(n)) {
      return ''; //S.current.validators_nameErrorFormat;
    } else {
      return null;
    }
  }

  static String? onValidatePhone(String? p) {
    if (p!.isEmpty) {
      return ''; //S.current.common_emptyPhone;
    } else if (!validatePhone(p)) {
      return ''; //S.current.common_errorPhone;
    } else {
      return null;
    }
  }

  static String? onValidateEmail(String? e) {
    if (e!.isEmpty) {
      return ''; //S.current.validators_emailEmpty;
    } else if (!validateEmail(e)) {
      return ''; //S.current.validators_emailErrorFormat;
    } else {
      return null;
    }
  }

  static String? onValidateAddress(String a) {
    if (a.isEmpty) {
      return ''; //S.current.validators_addressEmpty;
    } else if (!validateAddress(a)) {
      return ''; //S.current.validators_addressErrorFormat;
    } else {
      return null;
    }
  }
}

class ValidateUtil {
  static bool isEmptyOrNull(String? text) {
    return (text ?? "").isEmpty;
  }

  static String? validPhone(String? phone) {
    if (isEmptyOrNull(phone)) {
      return ''; //S.current.validators_phoneEmpty;
    } else if (!Validator.validatePhone(phone!)) {
      return ''; //S.current.validators_phoneErrorFormat;
    }
    return null;
  }
}
