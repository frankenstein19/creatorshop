import 'package:creator_shop/utils/utils.dart';
import 'package:creator_shop/utils/widgets/custom_background_widget.dart';
import 'package:creator_shop/utils/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/strings.dart';
import '../../utils/widgets/action_button.dart';
import '../../utils/widgets/animated_list_item.dart';
import 'bloc/create_account_bloc.dart';

class CreateAccountScreen extends StatefulWidget {
  static const path = "CreateAccountScreen";

  const CreateAccountScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAccountScreen();
}

class _CreateAccountScreen extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomBackgroundWidget(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: hPaddingFromScreen),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedListItem(
                    index: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Create Account!",
                          style: theme.textTheme.titleLarge,
                        ),
                        Text("Join our community",
                            style: theme.textTheme.bodyMedium)
                      ],
                    ),
                  ),
                  const SizedBox(height: vPaddingBetweenSectionWidgets),
                  AnimatedListItem(
                    index: 1,
                    child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
                      builder: (context, state) {
                        return InputField(
                          prefixIcon: const Icon(Icons.person),
                          hintText: StringConstants.firstName,
                          helperText: StringConstants.firstNameHelper,
                          errorText: state.firstName != null &&
                                  !state.firstName.validateInfo
                              ? StringConstants.firstNameHelper
                              : null,
                          keyboardType: TextInputType.text,
                          onChange: (v) =>
                              context.read<CreateAccountBloc>().add(
                                    UserDataChangeEvent(firstName: v),
                                  ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: vPaddingBetweenWidgets),
                  AnimatedListItem(
                    index: 2,
                    child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
                      builder: (context, state) {
                        return InputField(
                          prefixIcon: const Icon(Icons.person),
                          hintText: StringConstants.lastName,
                          helperText: StringConstants.lastNameHelper,
                          errorText: state.lastName != null &&
                                  !state.lastName.validateInfo
                              ? StringConstants.lastNameError
                              : null,
                          keyboardType: TextInputType.text,
                          onChange: (v) =>
                              context.read<CreateAccountBloc>().add(
                                    UserDataChangeEvent(lastName: v),
                                  ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: vPaddingBetweenWidgets),
                  AnimatedListItem(
                    index: 3,
                    child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
                      builder: (context, state) {
                        return InputField(
                          prefixIcon: const Icon(Icons.phone),
                          hintText: StringConstants.mobileNo,
                          helperText: StringConstants.mobileNoHelper,
                          errorText: state.mobile != null &&
                                  !state.mobile!.validateMobile
                              ? StringConstants.mobileNoError
                              : null,
                          keyboardType: TextInputType.phone,
                          onChange: (v) => context
                              .read<CreateAccountBloc>()
                              .add(UserDataChangeEvent(mobile: v)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: vPaddingBetweenWidgets),
                  AnimatedListItem(
                    index: 4,
                    child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
                      builder: (context, state) {
                        return InputField(
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: StringConstants.email,
                          helperText: StringConstants.emailHelper,
                          errorText:
                              state.email != null && !state.email!.isEmailValid
                                  ? StringConstants.emailError
                                  : null,
                          keyboardType: TextInputType.text,
                          onChange: (v) => context
                              .read<CreateAccountBloc>()
                              .add(UserDataChangeEvent(email: v)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: vPaddingBetweenWidgets),
                  AnimatedListItem(
                    index: 4,
                    child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
                      builder: (context, state) {
                        return InputField(
                          prefixIcon: const Icon(Icons.password_outlined),
                          hintText: StringConstants.password,
                          obscureText: true,
                          helperText: StringConstants.passwordHelper,
                          errorText: state.password != null &&
                                  !state.password!.isPasswordValid
                              ? StringConstants.passwordError
                              : null,
                          keyboardType: TextInputType.text,
                          onChange: (v) => context
                              .read<CreateAccountBloc>()
                              .add(UserDataChangeEvent(password: v)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: vPaddingBetweenSectionWidgets),
                  BlocBuilder<CreateAccountBloc, CreateAccountState>(
                    builder: (context, state) {
                      return AnimatedListItem(
                        index: 5,
                        child: ActionButton(
                            key: const Key("loginBtn"),
                            onPress:
                                state.canCreateAccount == true ? () {
                              context.read<CreateAccountBloc>().add(CreateNewAccount());
                                } : null,
                            child: state.inProgress
                                ? const CircularProgressIndicator()
                                : const Text(StringConstants.createAccount)),
                      );
                    },
                  ),
                  const SizedBox(height: vPaddingBetweenWidgets),
                  AnimatedListItem(
                    index: 6,
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(CreateAccountScreen.path);
                          },
                          child: const Text(StringConstants.backLogin)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
