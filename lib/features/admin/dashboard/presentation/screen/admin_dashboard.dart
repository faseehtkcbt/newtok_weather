import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/color_pallette/app_pallette.dart';
import 'package:newtok_weather/core/utils/app_text.dart';
import 'package:newtok_weather/core/utils/appbar_title.dart';
import 'package:newtok_weather/features/admin/dashboard/presentation/bloc/user_list_bloc.dart';

import '../../../../../config/route/routes.dart';
import '../../../../../core/utils/loader.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
@override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<UserListBloc>().add(GetUsers());
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'Newtok Admin'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, Routes.locationAddPage);
        },
        label: AppText(
            text: 'Add Location',
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
            return context.read<UserListBloc>().add(GetUsers());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Users List',
                textStyle: Theme.of(context).textTheme.bodyMedium,
                textSize: 19,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<UserListBloc, UserListState>(
                  builder: (context, user) {
                    if (user is UserListLoaded) {
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: user.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            tileColor: AppPellete.themeColor,
                            leading: const Icon(Icons.person_2_outlined,color: Colors.white,),
                            subtitle: AppText(
                              text: user.data[index].email??'',
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              textSize: 15,
                            ),
                            title: AppText(
                              text: user.data[index].name??'',
                              textStyle: Theme.of(context).textTheme.bodyMedium,
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
                    if (user is UserListError) {
                      return Center(
                        child: AppText(
                          text: user.failure.message,
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
      )),
    );
  }
}
