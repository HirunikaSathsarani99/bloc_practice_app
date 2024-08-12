import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:test_app/bloc/login_bloc/login_bloc.dart';
import 'package:test_app/bloc/university/university_bloc.dart';
import 'package:test_app/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UniversityBloc>(context).add(FetchUniversityData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Screen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(LogoutRequest());
          },
        ),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        
        builder: (context, state) {
          if (state is Logout) {
            return Login();
          }

          return Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<UniversityBloc, UniversityState>(
                    builder: (context, state) {
                      if (state is uniDataLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is uniDataloaded) {
                        return ListView.builder(
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            final uniData = state.data[index];
                            return Dismissible(
                              key: Key(uniData.name ?? ''),
                              onDismissed: (direction) {
                                BlocProvider.of<UniversityBloc>(context)
                                    .add(DeleteData(uniData));
                              },
                              child: ListTile(
                                title: Text(uniData.name.toString()),
                                subtitle: Text(uniData.country.toString()),
                              ),
                              background: Container(color: Colors.red),
                            );
                          },
                        );
                      } else if (state is uniDataError) {
                        return Text("Can't Load the data ");
                      }
                      return const Text("No data");
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
