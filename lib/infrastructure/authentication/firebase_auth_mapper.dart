import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/auth/auth_failure.dart';
import '../../domain/user/user.dart';


extension FirebaseUserX on firebase_auth.User? {
  User toDomain() {
    if (this == null) {
      return User.anonymous;
    } else {
      return User(
        id: this!.uid,
        displayName: this?.displayName,
        phoneNumber: this?.phoneNumber,
        isPhoneNumberVerified: this?.phoneNumber != null,
        email: this?.email,
        isEmailVerified: this!.emailVerified,
        photoURL: this?.photoURL,
        getIdToken: this!.getIdToken,
        joinDate: this!.metadata.creationTime,
      );
    }
  }
}

extension FirebaseErrorX on firebase_auth.FirebaseAuthException {
  AuthFailure toFailure() {
    print(code);
    if (code == 'network-request-failed') {
      return const AuthFailure.networkRequestFailed();
    } 

    if(code == 'user-not-found') {
      return const AuthFailure.userNotFound();
    }

    if(code == 'wrong-password') {
      return const AuthFailure.wrongPassword();
    }

    else {
      return const AuthFailure.serverError();
    }
  }
}