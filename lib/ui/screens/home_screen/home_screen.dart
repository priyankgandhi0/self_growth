import 'package:flutter/material.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

import '../../widgets/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("asa"),
      ),
      body: Container(
        child: Column(
          children: [
            AppButton(title: "Check"),
            AppTextField(
              hintText: "sdsd",
              validator: (value) {},
              showPrefixIcon: false,
              showSuffixIcon: false,
              suffixIcon: '',
              prefixIcon: '',
            )
          ],
        ),
      ),
    );
  }
}
