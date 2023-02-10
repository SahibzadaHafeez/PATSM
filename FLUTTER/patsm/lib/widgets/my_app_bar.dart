import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({Key? key, this.title}) : super(key: key);

  String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
      title != null?
          Text(title!)
      :
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  context.read<AppCubit>().homepage();
                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Home'),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<AppCubit>().history();
                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('History'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('About'),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              context.read<AppCubit>().logout();
            },
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
