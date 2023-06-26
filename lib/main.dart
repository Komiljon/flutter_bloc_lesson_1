import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_1/search_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyText2: TextStyle(fontSize: 33),
            subtitle1: TextStyle(fontSize: 22),
          ),
        ),
        home: const Scaffold(
          body: SafeArea(
            child: MyHomePage(),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = context.select((SearchBloc bloc) => bloc.state.users);
    if (users.isEmpty) {
      context.read<SearchBloc>().add(SearchUserEvent('---'));
    }
    return Column(
      children: [
        const Text('Search User'),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'User name',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<SearchBloc>().add(SearchUserEvent(value));
          },
        ),
        if (users.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                                users[index]['name'],
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              users[index]['address'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              users[index]['schedule'],
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: users.length,
            ),
          ),
      ],
    );
  }
}