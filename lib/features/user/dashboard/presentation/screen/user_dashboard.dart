import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/color_pallette/app_pallette.dart';
import 'package:newtok_weather/core/utils/app_text.dart';
import 'package:newtok_weather/core/utils/appbar_title.dart';
import 'package:newtok_weather/core/utils/loader.dart';
import 'package:newtok_weather/features/user/dashboard/presentation/bloc/location_bloc.dart';
import 'package:newtok_weather/features/user/weather/presentation/screen/weather_page.dart';

import '../../../../../config/route/routes.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationBloc>().add(GetLocation());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'User Dashboard'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addExcelPage);
        },
        label: AppText(
            text: 'Excel Upload',
            textStyle: Theme.of(context).textTheme.bodyMedium),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 10),
          child: RefreshIndicator(
            onRefresh: () async {
              return context.read<LocationBloc>().add(GetLocation());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Available Locations',
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  textSize: 19,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<LocationBloc, LocationState>(
                    builder: (context, location) {
                      if (location is LocationLoaded) {
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: location.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WeatherPage(
                                            entity: location.data[index])));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              tileColor: AppPellete.themeColor,
                              leading: const Icon(Icons.ads_click),
                              subtitle: AppText(
                                text:
                                    '${location.data[index].state},${location.data[index].country}',
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                textSize: 15,
                              ),
                              title: AppText(
                                text:
                                    '${location.data[index].city} - ${location.data[index].district}',
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                textSize: 17,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        );
                      }
                      if (location is LocationError) {
                        return Center(
                          child: AppText(
                            text: location.failure.message,
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 3,
                          ),
                        );
                      }
                      return const Center(
                        child: Loader(),
                      );
                    },
                    listener: (context, location) {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
