import 'package:creator_shop/presentation/create_account/create_account_screen.dart';
import 'package:creator_shop/utils/strings.dart';
import 'package:creator_shop/utils/utils.dart';
import 'package:creator_shop/utils/widgets/action_button.dart';
import 'package:creator_shop/utils/widgets/animated_list_item.dart';
import 'package:creator_shop/utils/widgets/custom_background_widget.dart';
import 'package:creator_shop/utils/widgets/input_field_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../country/country_screen.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const path = "/";

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    context.read<LoginBloc>().onLoginSuccess = onSuccess;
    return Scaffold(
      body: CustomBackgroundWidget(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(hPaddingFromScreen),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedListItem(
                  index: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Welcome!",style: theme.textTheme.titleLarge,),
                      Text("Login to continue",style: theme.textTheme.bodyMedium)

                    ],
                  ),
                ),
                const SizedBox(height: vPaddingBetweenSectionWidgets),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return AnimatedListItem(
                      index: 1,
                      child: InputField(
                        key: const Key("emailInput"),
                        keyboardType: TextInputType.emailAddress,
                        hintText: StringConstants.email,
                        helperText: StringConstants.emailHelper,
                        errorText: state.email.isNotEmpty &&
                            !state.email.isEmailValid
                            ? StringConstants.emailError
                            : null,
                        prefixIcon: const Icon(Icons.email_outlined),
                        onChange: (v) {
                          context.read<LoginBloc>().add(EmailChangedEvent(v));
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: vPaddingBetweenWidgets),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return AnimatedListItem(
                      index: 2,
                      child: InputField(
                        key: const Key("passwordInput"),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        hintText: StringConstants.password,
                        helperText: StringConstants.passwordHelper,
                        errorText: state.password.isNotEmpty &&
                            !state.password.isPasswordValid
                            ? StringConstants.passwordError
                            : null,
                        prefixIcon: const Icon(Icons.password_outlined),
                        onChange: (v) {
                          context.read<LoginBloc>().add(PasswordChangedEvent(v));
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: vPaddingBetweenSectionWidgets),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return AnimatedListItem(
                      index: 3,
                      child: ActionButton(
                          key: const Key("loginBtn"),
                          onPress: state.state == LoginButtonState.enable
                              ? () {
                            context.read<LoginBloc>().add(OnLoginEvent());
                          }
                              : null,
                          child: state.state == LoginButtonState.progress
                              ? const CircularProgressIndicator()
                              : const Text(StringConstants.login)),
                    );
                  },
                ),
                const SizedBox(height: vPaddingBetweenWidgets),
                AnimatedListItem(
                  index: 4,
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () async {
                        Navigator.of(context).pushNamed(CreateAccountScreen.path);
                        }, child: const Text(StringConstants.createAccount)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSuccess() =>
      Navigator.pushReplacementNamed(context, CountryScreen.path);
}
