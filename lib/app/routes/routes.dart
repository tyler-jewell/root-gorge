import 'package:flutter/material.dart';
import 'package:root_gorge/app/app.dart';
import 'package:root_gorge/home/home.dart';
import 'package:root_gorge/login/login.dart';

List<MaterialPage<void>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
