import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

chargement() {
  return Container(
      color: Colors.grey[900].withOpacity(0),
      child: SpinKitCircle(
        color: Colors.white,
        size: 60.0,
      ));
}
