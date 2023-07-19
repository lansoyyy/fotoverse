import 'package:flutter/material.dart';
import 'package:fotoverse/widgets/text_widget.dart';

import '../utils/colors.dart';

PreferredSizeWidget AppbarWidget(String title) {
  return AppBar(
    centerTitle: true,
    foregroundColor: primary,
    backgroundColor: Colors.white,
    title: TextRegular(text: title, fontSize: 24, color: primary),
  );
}
