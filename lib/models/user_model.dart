class UserModel {
  //Account Details
  String? email;
  // final String? password;
  String userType = 'normal';

  //Personal Details
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? phoneNo;

  //Address Details
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;

  UserModel(
      {required this.email,
      // required this.password,
      required this.firstName,
      required this.lastName,
      required this.dateOfBirth,
      required this.phoneNo,
      required this.addressLine1,
      required this.addressLine2,
      required this.city,
      required this.state});

  toJson() {
    return {
      'email': email,
      // 'password': password,
      'userType': userType,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'phoneNo': phoneNo,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      // password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      phoneNo: json['phoneNo'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      state: json['state'],
    );
  }
}
