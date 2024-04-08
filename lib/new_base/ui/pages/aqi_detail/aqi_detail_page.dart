import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollution_environment/new_base/commons/app_images.dart';
import 'package:pollution_environment/new_base/repositories/aqi_repository.dart';
import 'package:pollution_environment/new_base/ui/pages/aqi_detail/widgets/forecast_aqi.dart';
import 'package:pollution_environment/new_base/ui/components/aqi_weather_card.dart';
import 'package:pollution_environment/services/commons/helper.dart';
import 'package:pollution_environment/views/screen/home/components/pollution_aqi_items.dart';

import 'aqi_detail_cubit.dart';

class AqiDetailArguments {
  String param;

  AqiDetailArguments({
    required this.param,
  });
}

class AqiDetailPage extends StatelessWidget {
  final AqiDetailArguments arguments;

  const AqiDetailPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final aqiRepository = RepositoryProvider.of<AqiRepository>(context);
        return AqiDetailCubit(aqiRepository);
      },
      child: AqiDetailChildPage(
        arguments: arguments,
      ),
    );
  }
}

class AqiDetailChildPage extends StatefulWidget {
  final AqiDetailArguments arguments;

  const AqiDetailChildPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<AqiDetailChildPage> createState() => _AqiDetailChildPageState();
}

class _AqiDetailChildPageState extends State<AqiDetailChildPage>
    with SingleTickerProviderStateMixin {
  late final AqiDetailCubit _cubit;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chất lượng không khí"),
      ),
      body: BlocBuilder<AqiDetailCubit, AqiDetailState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(5),
            children: [
              Text(
                state.wAqiIpResponse?.data?.city?.name ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                state.wAqiIpResponse?.data?.city?.location ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 10,
              ),
              if (state.wAqiIpResponse != null)
                AQIWeatherCard(aqi: state.wAqiIpResponse!),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              if (state.wAqiIpResponse != null)
                PollutionAqiItems(
                  aqi: state.wAqiIpResponse!,
                ),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              if (state.wAqiIpResponse != null) ...[
                _buildRecommend(),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
              ],
              const SizedBox(
                height: 10,
              ),
              if (state.wAqiIpResponse?.data?.forecast?.daily != null)
                ForecastAqi(
                  daily: state.wAqiIpResponse!.data!.forecast!.daily!,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRecommend() {
    return BlocBuilder<AqiDetailCubit, AqiDetailState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Khuyến nghị",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      _cubit.changeRecommend(0);
                    },
                    child: Card(
                      elevation: 3,
                      color: state.reCommentType == 0
                          ? getQualityColor(
                              getAQIRank(
                                (state.wAqiIpResponse?.data?.aqi ?? 0)
                                    .toDouble(),
                              ),
                            )
                          : null,
                      child: SizedBox(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                AppImages.healthy,
                                height: 32,
                                width: 32,
                              ),
                              const Expanded(
                                child: Text(
                                  "Sức khỏe",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _cubit.changeRecommend(1);
                    },
                    child: Card(
                      color: state.reCommentType == 1
                          ? getQualityColor(
                              getAQIRank(
                                (state.wAqiIpResponse?.data?.aqi ?? 0)
                                    .toDouble(),
                              ),
                            )
                          : null,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              AppImages.normalPeople,
                              height: 32,
                              width: 32,
                            ),
                            const Expanded(
                              child: Text(
                                "Người bình thường",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _cubit.changeRecommend(2);
                    },
                    child: Card(
                      color: state.reCommentType == 2
                          ? getQualityColor(
                              getAQIRank(
                                (state.wAqiIpResponse?.data?.aqi ?? 0)
                                    .toDouble(),
                              ),
                            )
                          : null,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              AppImages.sensitivePeople,
                              height: 32,
                              width: 32,
                            ),
                            const Expanded(
                              child: Text(
                                "Người nhạy cảm",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 3,
              color: getQualityColor(
                getAQIRank(
                  (state.wAqiIpResponse?.data?.aqi ?? 0).toDouble(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  state.recommend ?? '',
                  style: TextStyle(
                    color: getTextColorRank(
                      getAQIRank(
                          (state.wAqiIpResponse?.data?.aqi ?? 0).toDouble()),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
