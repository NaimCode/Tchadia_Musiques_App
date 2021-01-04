import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestoreinstance = FirebaseFirestore.instance;

//final facebookSignIn = FacebookLoginWeb();

class Authentification {
  FirebaseAuth _firebaseAuth;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  Authentification(this._firebaseAuth);
  deconnection() async {
    await _firebaseAuth.signOut();
  }

  signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'Fluse': 'wfluse@gmail.com'});

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithPopup(googleProvider).then((value) {
      print(value.user.displayName);
      var user = value.user;
      print(user.displayName);
      FirebaseFirestore.instance
          .collection('Utilisateur')
          .doc(user.uid)
          .get()
          .then((value) async {
        if (!value.exists) {
          print('enregistrement');

          var utilisateurs = {
            'nom': user.displayName,
            'email': user.email,
            'password': null,
            'image': user.photoURL,
            'universite': null,
            'semestre': null,
            'filiere': null,
            'admin': false,
            'uid': user.uid,
          };

          await firestoreinstance
              .collection('Utilisateur')
              .doc(user.uid)
              .set(utilisateurs);
        }
      });
    });

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  // signInWithFacebook() async {
  //   final result = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   final FacebookAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(result.token);

  //   // Once signed in, return the UserCredential
  //   var user = await FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential);
  //   if (user.additionalUserInfo.isNewUser) {
  //     List<String> favori = [], historique = [];
  //     //  var user = await FirebaseAuth.instance.print(graphResponse.body);
  //     var utilisateurs = {
  //       'nom': user.user.displayName,
  //       'email': user.user.email,
  //       'password': 'pas de mot passe',
  //       'image': null,
  //       'admin': false,
  //       'uid': user.user.uid,
  //       'favori': favori,
  //       'historique': historique,
  //     };

  //     await firestoreinstance
  //         .collection('Chef')
  //         .doc(user.user.uid)
  //         .set(utilisateurs);
  //   }
  //      switch (facebookAuthCredential) {
  //   case FacebookLoginStatus.loggedIn:
  //     var user = await FirebaseAuth.instance.print(graphResponse.body);
  //     // _sendTokenToServer(result.accessToken.token);
  //     // _showLoggedInUI();
  //     break;
  //   case FacebookLoginStatus.cancelledByUser:
  //     // _showCancelledMessage();
  //     break;
  //   case FacebookLoginStatus.error:
  //     // _showErrorOnUI(result.errorMessage);
  //     break;
  // }
  // print(user.additionalUserInfo.isNewUser.toString());
  // print(user.additionalUserInfo.username);
  // final facebookLogin = FacebookLogin();
  // final result = await facebookLogin.logIn(['email']);
  // // final result = await facebookSignIn.logInWithReadPermissions(['email']);
  // final token = result.accessToken.token;
  // final graphResponse = await http.get(
  //     'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
  // //final profile = JSON.decode(graphResponse.body);
  // switch (result.status) {
  //   case FacebookLoginStatus.loggedIn:
  //     var user = await FirebaseAuth.instance.print(graphResponse.body);
  //     // _sendTokenToServer(result.accessToken.token);
  //     // _showLoggedInUI();
  //     break;
  //   case FacebookLoginStatus.cancelledByUser:
  //     // _showCancelledMessage();
  //     break;
  //   case FacebookLoginStatus.error:
  //     // _showErrorOnUI(result.errorMessage);
  //     break;
  // }
  //}

  enregistrementAuth(String mail, String password, String nom) async {
    try {
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      try {
        await user.user.sendEmailVerification();
        String image;
        // List<String> favori = [], historique = [];

        bool admin = false;
        var utilisateurs = {
          'nom': nom,
          'email': user.user.email,
          'follower': [],
          'image': image,
          'admin': admin,
          'uid': user.user.uid,
          'following': [],
        };

        await firestoreinstance
            .collection('Utilisateur')
            .doc(user.user.uid)
            .set(utilisateurs);
        return 'Enregistrement réussi, bienvenue à vous';
      } catch (e) {
        return 'L\'Email est invalide';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Le mot de passe est trop faible, minimum 6 caratères';
      } else if (e.code == 'email-already-in-use') {
        return 'Email existe déjà';
      }
    } catch (e) {
      print(e);
      return 'erreur';
    }
  }

  connection(String mail, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
      return 'Connexion réussi, ravis de vous revoir';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'L\'Email est incorrect';
      } else if (e.code == 'wrong-password') {
        return 'Le mot de passe est incorrect';
      }
    }
  }
}
