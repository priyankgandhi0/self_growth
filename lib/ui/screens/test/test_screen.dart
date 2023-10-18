import 'package:flutter/material.dart';
import 'package:self_growth/ui/widgets/app_bottom_sheet_dialog.dart';
import 'package:self_growth/ui/widgets/habit_card.dart';
import 'package:self_growth/ui/widgets/login_popup.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';
import 'package:self_growth/ui/widgets/title_bar.dart';

import '../../widgets/app_button.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("login"),
      ),
      body: Column(
        children: [
          const HabitCard(),
          TitleBar(
            title: 'asas',
            isCenter: true,
          ),
          AppButton(
              title: "Login",
              onPress: () {
                appCustomBottomSheet(
                    context: context,
                    child: LoginPopup(
                      onLogin: (login) {},
                      onForgotPassword: () {},
                    ));
              }),
          AppTextField(
            hintText: "sdsd",
            validator: (value) {},
            showPrefixIcon: false,
            showSuffixIcon: false,
            suffixIcon: '',
            prefixIcon: '',
          ),
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
    );
  }
}
