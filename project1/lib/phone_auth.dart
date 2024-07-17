import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendOTPCode(String phoneNo, Function(String) onCodeSent) async {
    // Ensure phone number has country code prefix
    String phoneNumber = phoneNo.startsWith('+91') ? phoneNo : '+91$phoneNo';

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        print(
            'Phone number automatically verified and user signed in: ${_auth.currentUser?.uid}');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Phone number verification failed: ${e.code}');
      },
      codeSent: (String verificationId, int? resendToken) {
        print('Please check your phone for the verification code.');
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Verification code: $verificationId');
        onCodeSent(verificationId);
      },
    );
  }

  Future<String> verifyOTPCode(
      {required String verificationId, required String otp}) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final User? user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        await storeNumber(user.phoneNumber!);
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> storeNumber(String phoneNo) async {
    try {
      await _firestore.collection('users').doc(phoneNo).set({
        'phoneNumber': phoneNo,
      });
    } catch (e) {
      print('Error storing number: ${e.toString()}');
    }
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';


// class PhoneAuthScreen extends StatefulWidget {
//   const PhoneAuthScreen({super.key});

//   @override
//   State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
// }

// class _PhoneAuthScreenState extends State<PhoneAuthScreen> {

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   late String _verificationId;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Phone Authentication'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(
//                   labelText: 'Phone Number',
//                 ),
//                 keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 16,),
//             ElevatedButton(
//               onPressed: _verifyPhoneNumber, 
//               child: Text('Verify Phone number'),
//             ),
//             TextField(
//               controller: _otpController,
//               decoration: InputDecoration(
//                 labelText: 'OTP',
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 10,),
//             ElevatedButton(
//               onPressed: _signInWithPhoneNumber, 
//               child: Text('Sign in with OTP'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _verifyPhoneNumber() async {
//     final PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential credential) async {
//       await _auth.signInWithCredential(credential);
//       print('Phone number automatically verifiedand user signed in: ${_auth.currentUser?.uid}');
//     };

//     final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
//       print('Phone Number verification failed ${e.code}');
//     };

//     final PhoneCodeSent codeSent = (String verificationId, int? resendToken) async {
//       print('Please check your phone for the verfication code');
//       setState(() {
//         _verificationId = verificationId;
//       });
//     };

//     final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
//       print('verification code: ${verificationId}');
//       setState(() {
//         _verificationId = verificationId;
//       });
//     };


//     await _auth.verifyPhoneNumber(
//       phoneNumber: _phoneController.text,
//       timeout: Duration(seconds: 60),
//       verificationCompleted: verificationCompleted,
//       verificationFailed: verificationFailed,
//       codeSent: codeSent,
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//     );
//   }

//   void _signInWithPhoneNumber() async {
//     try {
//       final AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId, 
//         smsCode: _otpController.text,
//       );
//       final User? user = (await _auth.signInWithCredential(credential)).user;
//       print('Successfully signed in UID: ${user!.uid}');
//     } catch (e) {
//       print('Failed to sign in: $e');
//     }
//   }



// }










// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class PhoneAuthentication {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> sendOTPCode(String phoneNo, Function(String) onCodeSent) async {
//     await _auth.verifyPhoneNumber(
//       timeout: const Duration(seconds: 40),
//       phoneNumber: '+91 $phoneNo',
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         print("Verification completed automatically.");
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print("Verification failed: ${e.message}");
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         onCodeSent(verificationId);
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         print("Code auto-retrieval timeout: $verificationId");
//       },
//     );
//   }

//   Future<String> verifyOTPCode({
//     required String verifyId,
//     required String otp,
//   }) async {
//     try {
//       final PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
//         verificationId: verifyId,
//         smsCode: otp,
//       );
//       final UserCredential userCredential =
//           await _auth.signInWithCredential(authCredential);
//       if (userCredential.user != null) {
//         await storeNumber(userCredential.user!.phoneNumber!);
//         return "success";
//       } else {
//         return "error";
//       }
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<void> storeNumber(String phoneNo) async {
//     try {
//       await _firestore.collection('users').doc(phoneNo).set({
//         'phoneNumber': phoneNo,
//       });
//     } catch (e) {
//       print("Error storing number: ${e.toString()}");
//     }
//   }
// }
// //THE OTP DEFAULTLY SET IS 152000  (OTP==15200)