import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_pasword_cubit.dart';

class ForgotPaswordArguments {
  String param;

  ForgotPaswordArguments({
    required this.param,
  });
}

class ForgotPaswordPage extends StatelessWidget {
  final ForgotPaswordArguments arguments;

  const ForgotPaswordPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ForgotPaswordCubit();
      },
      child: const ForgotPaswordChildPage(),
    );
  }
}

class ForgotPaswordChildPage extends StatefulWidget {
  const ForgotPaswordChildPage({Key? key}) : super(key: key);

  @override
  State<ForgotPaswordChildPage> createState() => _ForgotPaswordChildPageState();
}

class _ForgotPaswordChildPageState extends State<ForgotPaswordChildPage> {
  late final ForgotPaswordCubit _cubit;

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
