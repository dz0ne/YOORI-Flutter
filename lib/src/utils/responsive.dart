import 'package:flutter/material.dart';

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 450;
bool isTab(BuildContext context) => MediaQuery.of(context).size.width < 180 && MediaQuery.of(context).size.width >= 650;
bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1300;