import 'package:expandable_card/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:music_app3/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'constante/widget.dart';
import 'service/authentification.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String selectItemNav = 'se connecter';
  bool obscure = true;
  bool isCharging = false;

  //////////////Section connection
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  bool erreurPassword = false;
  bool erreurMail = false;
  bool connectable = true;
  connexionVerif() async {
    setState(() {
      isCharging = true;
    });
    if (!mail.text.isEmail) {
      setState(() {
        erreurMail = true;
      });
    } else {
      var check = await context
          .read<Authentification>()
          .connection(mail.text.trim(), password.text.trim());
      // Get.snackbar('Connexion', check,
      //     icon: (check == 'Connexion réussi, ravis de vous revoir')
      //         ? Icon(Icons.verified, color: Colors.white)
      //         : Icon(
      //             Icons.error_sharp,
      //             color: Colors.red,
      //           ));
      switch (check) {
        case 'Connexion réussie, ravis de vous revoir':
          //go home
          break;
        case 'L\'Email est incorrect':
          setState(() {
            erreurMail = true;
          });
          break;
        case 'Le mot de passe est incorrect':
          setState(() {
            erreurPassword = true;
            erreurMail = false;
          });
          break;
        default:
      }
    }
    setState(() {
      isCharging = false;
    });
  }

  /////////////////
  /////////////////Section enregistrement
  TextEditingController mailE = TextEditingController();
  TextEditingController passwordE = TextEditingController();
  TextEditingController nomE = TextEditingController();
  bool erreurPasswordE = false;
  bool erreurMailE = false;
  bool erreurNomE = false;
  bool connectableE = true;
  enregistrementVerif() async {
    setState(() {
      isCharging = true;
    });
    if (!mailE.text.isEmail) {
      Get.rawSnackbar(
          title: 'Enregistrement',
          message: 'L\'Email est incorrect',
          icon: Icon(
            Icons.error_sharp,
            color: Colors.red,
          ));
      setState(() {
        erreurMailE = true;
      });
    } else {
      String check = await context.read<Authentification>().enregistrementAuth(
          mailE.text.trim(), passwordE.text.trim(), nomE.text.trim());
      // Get.snackbar('Enregistrement', check,
      //     icon: Icon(
      //       (check == 'Enregistrement réussi, bienvenue à vous')
      //           ? Icon(Icons.verified, color: Colors.white)
      //           : Icons.error_sharp,
      //       color: Colors.red,
      //     ));

      switch (check) {
        case 'Enregistrement réussi, bienvenue à vous':

          //go home
          break;
        case 'Email existe déjà':
          setState(() {
            erreurMailE = true;
          });
          break;
        case 'Le mot de passe est trop faible, minimum 6 caratères':
          setState(() {
            erreurPasswordE = true;
            erreurMailE = false;
          });
          break;
        case 'L\'Email est invalide':
          setState(() {
            erreurMailE = true;
          });
          break;
        default:
      }
    }
    setState(() {
      isCharging = false;
    });
  }

  String fonttitle = FontsTitle;
  String font = Fonts;
  TextEditingController titreInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: ExpandableCardPage(
        //     page: Container(
        //       color: Colors.white,
        //       padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        //       child: Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Container(
        //               child: Text(
        //                 'TCHADIA',
        //                 style: TextStyle(
        //                     color: Colors.indigo[900],
        //                     fontFamily: font,
        //                     fontSize: 40.0),
        //               ),
        //             ),
        //             Lottie.asset('assets/splashAnimated.json'),
        //             Container(
        //               child: Text(
        //                 'Découvrez la première application de partage musical tchadienne!',
        //                 style: TextStyle(
        //                     color: Colors.indigo[900],
        //                     fontFamily: font,
        //                     fontSize: 18.0),
        //                 textAlign: TextAlign.center,
        //               ),
        //             ),
        //             Container()
        //           ],
        //         ),
        //       ),
        //     ),
        //     expandableCard: ExpandableCard(
        //         padding: EdgeInsets.only(top: 10, left: 8, right: 8),
        //         hasRoundedCorners: true,
        //         hasHandle: false,
        //         minHeight: 70,
        //         maxHeight: Get.height - 100,
        //         backgroundColor: Colors.white,
        //         children: [
        body: Container(
      decoration: linear(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          selectButton(),
          (selectItemNav == 'se connecter')
              ? connectionSection()
              : enregistrementSection(),
        ],
      ),
    )
        //]))
        );
  }

  Center selectButton() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
            left: (MediaQuery.of(context).size.width <= 340) ? 0.0 : 35.0),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    selectItemNav = 'se connecter';
                  });
                },
                child: Container(
                  decoration: (selectItemNav == 'se connecter')
                      ? BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              //                    <--- top side
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        )
                      : null,
                  height: 30.0,
                  child: Text(
                    'Se connecter',
                    style: TextStyle(
                        fontFamily: 'Tomorrow',
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    selectItemNav = 's\'enregistrer';
                  });
                },
                child: Container(
                  decoration: (selectItemNav == 's\'enregistrer')
                      ? BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              //                    <--- top side
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        )
                      : null,
                  height: 30.0,
                  child: Text(
                    'S\'enregistrer',
                    style: TextStyle(
                        fontFamily: 'Tomorrow',
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container enregistrementSection() {
    return Container(
      child: Column(
        children: [
          Container(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.person_sharp,color:Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      //                    <--- top side
                      color: erreurNomE ? Colors.red : Colors.purple[900],
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width:
                      (MediaQuery.of(context).size.width <= 340) ? 240 : 290.0,
                  child: TextFormField(
                    controller: nomE,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Nom',hintStyle: TextStyle(color: Colors.white38),),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.mail,color:Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      //                    <--- top side
                      color: erreurMailE ? Colors.red : primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width:
                      (MediaQuery.of(context).size.width <= 340) ? 240 : 290.0,
                  child: TextFormField(
                    controller: mailE,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Email',hintStyle: TextStyle(color: Colors.white38),),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.lock, color:Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      //                    <--- top side
                      color: erreurPasswordE ? Colors.red : primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width:
                      (MediaQuery.of(context).size.width <= 340) ? 240 : 290.0,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        controller: passwordE,
                        obscureText: obscure ? true : false,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: 'Mot de passe',hintStyle: TextStyle(color: Colors.white38),),
                      ),
                      IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: obscure
                            ? Icon(
                                Icons.visibility,
                                size: 20,color:Colors.white
                              )
                            : Icon(Icons.visibility_off, size: 20,color:Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Si vous avez déjà un compte, veuillez-vous connecter',
                  style: TextStyle(fontFamily: 'Didac', fontSize: 12,color: Colors.white38))
            ),
          ),
          isCharging
              ? chargement()
              : Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Tooltip(
                    message: 'Valider',
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: primary,
                      onPressed: enregistrementVerif,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 30.0),
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Center connectionSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.mail, color: Colors.white),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            //                    <--- top side
                            color: erreurMail ? Colors.red : Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                            controller: mail,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 5, top: 5, right: 15),
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.white38),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Row(
                  // alignment: WrapAlignment.center,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.lock, color: Colors.white),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            //                    <--- top side
                            color: erreurPassword ? Colors.red : Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextFormField(
                              controller: password,
                              obscureText: obscure ? true : false,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: 'Mot de passe',
                                hintStyle: TextStyle(color: Colors.white38),
                              ),
                            ),
                            IconButton(
                              alignment: Alignment.centerRight,
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              icon: obscure
                                  ? Icon(
                                      Icons.visibility,
                                      size: 20,
                                    )
                                  : Icon(Icons.visibility_off,
                                      size: 20, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Si vous n\'avez pas encore un compte, veuillez-vous enregistrer',
                    style: TextStyle(fontFamily: 'Didac', fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              isCharging
                  ? chargement()
                  : Container(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Tooltip(
                        message: 'Valider',
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.purple,
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 30.0),
                            child: Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
