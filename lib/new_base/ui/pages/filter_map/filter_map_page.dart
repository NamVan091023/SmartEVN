import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_map_cubit.dart';

class FilterMapArguments {
  String param;

  FilterMapArguments({
    required this.param,
  });
}

class FilterMapPage extends StatelessWidget {
  final FilterMapArguments arguments;

  const FilterMapPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return FilterMapCubit();
      },
      child: const FilterMapChildPage(),
    );
  }
}

class FilterMapChildPage extends StatefulWidget {
  const FilterMapChildPage({Key? key}) : super(key: key);

  @override
  State<FilterMapChildPage> createState() => _FilterMapChildPageState();
}

class _FilterMapChildPageState extends State<FilterMapChildPage> {
  late final FilterMapCubit _cubit;

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
