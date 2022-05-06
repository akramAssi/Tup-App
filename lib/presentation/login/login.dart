import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_app/app/di.dart';
import 'package:test_app/presentation/login/login_viewmodel.dart';
import 'package:test_app/presentation/login/widget/custom_text_field.dart';
import 'package:test_app/presentation/resources/assets_mangers.dart';
import 'package:test_app/presentation/resources/routes_manager.dart';
import 'package:test_app/presentation/resources/string_manager.dart';
import 'package:test_app/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance.get<LoginViewModel>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _usernameController
        .addListener(() => _viewModel.setUserName(_usernameController.text));
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double padding = AppPadding.p6w;
    var space = const SizedBox(
      height: 30,
    );
    var space1_2 = const SizedBox(
      height: 15,
    );
    return Scaffold(
        body: Form(
      key: _formKey,
      child: SafeArea(
        child: SingleChildScrollView(
            child: SizedBox(
          height: 100.h,
          child: Padding(
            padding: EdgeInsets.only(right: padding, left: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  ImageAsset.splashLogo,
                ),
                StreamBuilder(
                    stream: _viewModel.outputUserNameValid,
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      return CustomeTextField(
                        controller: _usernameController,
                        labelText: AppStrings.username,
                        errorText: showErrorText(snapshot),
                      );
                    }),
                space,
                StreamBuilder(builder: (context, AsyncSnapshot<bool> snapshot) {
                  return CustomeTextField(
                    controller: _passwordController,
                    labelText: AppStrings.password,
                    errorText: showErrorText(snapshot),
                  );
                }),
                space,
                space,
                StreamBuilder(
                    stream: _viewModel.outputAllInputValid,
                    builder: (context, AsyncSnapshot<bool?> snapshot) {
                      return ElevatedButton(
                          onPressed:
                              snapshot.data ?? false ? _viewModel.login : null,
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12)),
                          child: const Text(
                            AppStrings.login,
                            style: TextStyle(fontSize: AppSize.s20),
                          ));
                    }),
                space1_2,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.forgotPasswordRoute);
                      },
                      child: const Text(AppStrings.forgetPassword),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.registerRoute);
                      },
                      child: const Text(AppStrings.notMember),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    ));
  }

  String? showErrorText(AsyncSnapshot<bool> snapshot) {
    return (snapshot.data ?? true) ? null : AppStrings.required;
  }
}
