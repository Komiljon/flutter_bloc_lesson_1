// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_1/blocs/stores_bloc/stores_bloc.dart';

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
          create: (context) => StoresBloc(),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int list_count = 10;

  @override
  Widget build(BuildContext context) {
    final stores = context.select((StoresBloc bloc) => bloc.state.stores);
    if (stores.isEmpty) {
      context.read<StoresBloc>().add(StoresListEvent('---'));
    }

    return Column(
      children: [
        const Text('Stores List'),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'User name',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<StoresBloc>().add(StoresListEvent(value));
          },
        ),
        if (stores.isNotEmpty)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8.0),
              itemCount: (stores.length > list_count) ? list_count : stores.length,
              itemBuilder: (context, index) {
                if (stores.length > list_count && index == list_count - 1) {
                  return Container(
                  padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                  alignment: Alignment.center,
                  child: SizedBox(
                  width: 175.0,
                  height: 40.0,
                  child: OutlinedButton(
                  onPressed: () {
                  setState(() {
                    list_count += 10;
                  });
                  },
                  style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  maximumSize: const Size(175, 40),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  ),
                  side: const BorderSide(width: 1.0, color: Color(0xFFde002b)),
                  ),
                  child: const Text(
                  "Показать еще 10",
                  style: TextStyle(fontSize: 18, color: Color(0xFFde002b)),
                  ),
                  ),
                  ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 5.0,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Text(
                                      stores[index]['name'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                                    )),
                                //Icon(AkaIcons.heart, size: 24,),
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
                                    stores[index]['address'],
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
                                    stores[index]['schedule'],
                                    style: const TextStyle(fontSize: 14.0),
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
                                  child: SelectableText(
                                    stores[index]['phone'],
                                    style:
                                    const TextStyle(fontSize: 14.0, decoration: TextDecoration.underline),
                                    onTap: () {
                                      //_launchUrl("tel:${stores[index].phoneto}");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
      ],
    );
  }
}
