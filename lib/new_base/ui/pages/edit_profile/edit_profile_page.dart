import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_profile_cubit.dart';

class EditProfileArguments {
  String param;

  EditProfileArguments({
    required this.param,
  });
}

class EditProfilePage extends StatelessWidget {
  final EditProfileArguments arguments;

  const EditProfilePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return EditProfileCubit(
        );
      },
      child: const EditProfileChildPage(),
    );
  }
}

class EditProfileChildPage extends StatefulWidget {
  const EditProfileChildPage({Key? key}) : super(key: key);

  @override
  State<EditProfileChildPage> createState() => _EditProfileChildPageState();
}

class _EditProfileChildPageState extends State<EditProfileChildPage> {
  late final EditProfileCubit _cubit;

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
