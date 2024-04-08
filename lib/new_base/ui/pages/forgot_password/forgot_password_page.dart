import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_password_cubit.dart';

class ForgotPasswordArguments {
  String param;

  ForgotPasswordArguments({
    required this.param,
  });
}

class ForgotPasswordPage extends StatelessWidget {
  final ForgotPasswordArguments arguments;

  const ForgotPasswordPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ForgotPasswordCubit();
      },
      child: const ForgotPasswordChildPage(),
    );
  }
}

class ForgotPasswordChildPage extends StatefulWidget {
  const ForgotPasswordChildPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordChildPage> createState() =>
      _ForgotPasswordChildPageState();
}

class _ForgotPasswordChildPageState extends State<ForgotPasswordChildPage> {
  late final ForgotPasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
