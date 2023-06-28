class UserModel {
  //Account Details
  final String? email;
  // final String? password;
  final String userType = 'normal';

  //Personal Details
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? phoneNo;

  //Address Details
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;

  const UserModel(
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
}
