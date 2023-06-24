class RegexConstants {
  static final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static final RegExp firstNameRegex = RegExp(
    r'^[a-zA-Z]+$',
  );

  static final RegExp lastNameRegex = RegExp(
    r'^[a-zA-Z]+$',
  );

  static final RegExp phoneNumberRegex = RegExp(
    r'^[0-9]{10}$',
  );

  static final RegExp addressLineRegex = RegExp(
    r'^[a-zA-Z0-9\s-]{1,100}$',
  );

  static final RegExp cityRegex = RegExp(
    r'^[a-zA-Z\s]+$',
  );

  static final RegExp stateRegex = RegExp(
    r'^[a-zA-Z\s]+$',
  );
}
