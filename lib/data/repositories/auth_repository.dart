import 'package:authapp/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class AuthRepository {
  final _firebaseAuth;
  var verificationId = '';

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
//phone auth
  Future<void> phoneAuth(String phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          print("wrong number");
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var usrCredential = await _firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: this.verificationId, smsCode: otp));

    return usrCredential.user != null ? true : false;
  }

  Future<bool> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      var u = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user);

      u!.updateDisplayName(firstName + "\t" + lastName);
      if (u != null) {
        return true;
      }
    } on FirebaseAuthException catch (firebaseError) {
      if (firebaseError.code == 'Weak-password') {
        throw Exception("Weak password");
      } else if (firebaseError.email == 'email-already-in-use') {
        throw Exception(
            "You have already signed up with this email, please login!");
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return false;
  }

  Future<void> SignIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (fireAuthErr) {
      if (fireAuthErr.code == 'Invalid-email') {
        throw Exception("Invalid mail Id");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // User? get currentUser {
  //   return _firebaseAuth.;
  // }

  // phone auth

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<UserCredential> verifyAndLogin(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    return _firebaseAuth.signInWithCredential(authCredential);
  }

  Future<User> getUser() async {
    User user = await _firebaseAuth.currentUser?.uid;
    return user;
  }
}
