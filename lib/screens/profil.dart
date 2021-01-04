import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../obs.dart';
import '../splash.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => isConnected.value == '' ? Splash() : ProfilUser());
  }
}

class ProfilUser extends StatefulWidget {
  @override
  _ProfilUserState createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUser> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
